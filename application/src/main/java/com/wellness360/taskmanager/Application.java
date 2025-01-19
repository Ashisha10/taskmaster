package com.wellness360.taskmanager;

import com.wellness360.taskmanager.controller.TaskController;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
//@ComponentScan(basePackages = {"com.wellness360.taskmanager.controller", "com.wellness360.taskmanager.service"})
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
