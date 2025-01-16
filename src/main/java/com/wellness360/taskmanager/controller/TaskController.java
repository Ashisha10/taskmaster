package com.wellness360.taskmanager.controller;

import com.wellness360.taskmanager.dto.Task;
import com.wellness360.taskmanager.service.TaskService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.logging.Logger;

@RestController
@RequestMapping("/api/tasks")
public class TaskController {

    private static final Logger logger = Logger.getLogger(TaskController.class.getName());

    @Autowired
    private TaskService taskService;

    @GetMapping
    public ResponseEntity<List<Task>> getAllTasks() {
        List<Task> tasks = taskService.getAllTasks();
        logger.info("200 OK: Retrieved all tasks");
        return ResponseEntity.ok(tasks);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Task> getTaskById(@PathVariable Long id) {
        Optional<Task> task = taskService.getTaskById(id);
        if (task.isPresent()) {
            logger.info("200 OK: Retrieved task with id " + id);
            return ResponseEntity.ok(task.get());
        } else {
            logger.warning("404 NOT FOUND: Task with id " + id + " not found");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    @PostMapping
    public ResponseEntity<?> createTask(@RequestBody Task task) {
        if (task.getTitle() == null || task.getTitle().isEmpty()) {
            logger.warning("400 BAD REQUEST: Task title is required");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Task title is required");
        }
        Task createdTask = taskService.createTask(task);
        logger.info("201 CREATED: Task created with id " + createdTask.getId());
        return ResponseEntity.status(HttpStatus.CREATED).body(createdTask);
    }


    @PutMapping("/{id}")
    public ResponseEntity<Task> updateTask(@PathVariable Long id, @RequestBody Task updatedTask) {
        try {
            Task updated = taskService.updateTask(id, updatedTask);
            logger.info("200 OK: Task updated with id " + id);
            return ResponseEntity.ok(updated);
        } catch (RuntimeException e) {
            logger.warning("404 NOT FOUND: Task with id " + id + " not found for update");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTask(@PathVariable Long id) {
        try {
            taskService.deleteTask(id);
            logger.info("204 NO CONTENT: Task deleted with id " + id);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException e) {
            logger.warning("404 NOT FOUND: Task with id " + id + " not found for deletion");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }
}