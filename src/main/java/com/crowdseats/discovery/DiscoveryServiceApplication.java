package com.crowdseats.discovery;

import de.codecentric.boot.admin.server.config.EnableAdminServer;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

@SpringBootApplication
@EnableEurekaServer
@EnableAdminServer
public class DiscoveryServiceApplication {

	public static void main(String[] args) {
		System.setProperty("service.name", "discovery");
		SpringApplication.run(DiscoveryServiceApplication.class, args);
	}

}
