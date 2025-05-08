package com.gen.cinema.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.gen.cinema.audit.Principal;
import com.gen.cinema.security.CustomAuthenticationEntryPoint;
import com.gen.cinema.security.CustomAccessDeniedHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    
    private static final Logger logger = LoggerFactory.getLogger(SecurityConfig.class);

    private final CustomAuthenticationEntryPoint customAuthenticationEntryPoint;
    private final CustomAccessDeniedHandler customAccessDeniedHandler;
    private final TimeZoneFilter timeZoneFilter;

    public SecurityConfig(
            CustomAuthenticationEntryPoint customAuthenticationEntryPoint,
            CustomAccessDeniedHandler customAccessDeniedHandler,
            TimeZoneFilter timeZoneFilter) {
        this.customAuthenticationEntryPoint = customAuthenticationEntryPoint;
        this.customAccessDeniedHandler = customAccessDeniedHandler;
        this.timeZoneFilter = timeZoneFilter;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf(AbstractHttpConfigurer::disable)
            .addFilterBefore(timeZoneFilter, UsernamePasswordAuthenticationFilter.class)
            .exceptionHandling(exceptionHandling -> exceptionHandling
                .authenticationEntryPoint(customAuthenticationEntryPoint)
                .accessDeniedHandler(customAccessDeniedHandler)
            )
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/v1/master-tlv/**").permitAll()
                .requestMatchers("/v1/user/configuration/**").authenticated()
                .anyRequest().authenticated()
            )
            .httpBasic(basic -> basic.realmName("Excentis Config File"));
        
        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public UserDetailsService userDetailsService(PasswordEncoder passwordEncoder) {
        logger.debug("Creating UserDetailsService with users:");
        
        Principal admin = new Principal("admin");
        admin.setUserId("0001");
        admin.setPassword(passwordEncoder.encode("password"));
        logger.debug("Created admin user: name={}, userId={}", admin.getName(), admin.getUserId());

        Principal user = new Principal("user");
        user.setUserId("0002");
        user.setPassword(passwordEncoder.encode("password"));
        logger.debug("Created user: name={}, userId={}", user.getName(), user.getUserId());

        return username -> {
            logger.debug("Loading user: {}", username);
            if ("admin".equals(username)) {
                return admin;
            } else if ("user".equals(username)) {
                return user;
            }
            throw new UsernameNotFoundException("User not found: " + username);
        };
    }
} 