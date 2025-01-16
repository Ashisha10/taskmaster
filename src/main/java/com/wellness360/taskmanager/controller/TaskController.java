package com.wellness360.taskmanager.controller;

import com.wellness360.taskmanager.dto.Task;
import com.wellness360.taskmanager.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import io.micrometer.core.instrument.MeterRegistry;
import io.micrometer.core.instrument.Counter;
import io.micrometer.core.instrument.Timer;

import jakarta.annotation.PostConstruct;
import java.util.List;
import java.util.Optional;
import java.util.logging.Logger;

@RestController
@RequestMapping("/api/tasks")
public class TaskController {

    private static final Logger logger = Logger.getLogger(TaskController.class.getName());

    @Autowired
    private TaskService taskService;

    // Inject the MeterRegistry for metrics
    @Autowired
    private MeterRegistry meterRegistry;

    // Define counters for successful API requests
    private final Counter getAllSuccessCounter;
    private final Counter getByIdSuccessCounter;
    private final Counter createTaskSuccessCounter;

    // Define timers for API request processing times
    private final Timer getAllTimer;
    private final Timer getByIdTimer;
    private final Timer createTaskTimer;

    @Autowired
    public TaskController(TaskService taskService, MeterRegistry meterRegistry) {
        this.taskService = taskService;
        this.meterRegistry = meterRegistry;

        // Initialize counters
        this.getAllSuccessCounter = meterRegistry.counter("api.tasks.getAll.success");
        this.getByIdSuccessCounter = meterRegistry.counter("api.tasks.getById.success");
        this.createTaskSuccessCounter = meterRegistry.counter("api.tasks.create.success");

        // Initialize timers
        this.getAllTimer = meterRegistry.timer("api.tasks.getAll.timer");
        this.getByIdTimer = meterRegistry.timer("api.tasks.getById.timer");
        this.createTaskTimer = meterRegistry.timer("api.tasks.create.timer");
    }

    @GetMapping
    public ResponseEntity<List<Task>> getAllTasks() {
        // Start the timer for this method
        Timer.Sample sample = Timer.start(meterRegistry);
        try {
            List<Task> tasks = taskService.getAllTasks();
            getAllSuccessCounter.increment();  // Increment success counter
            logger.info("200 OK: Retrieved all tasks");
            return ResponseEntity.ok(tasks);
        } finally {
            sample.stop(getAllTimer);  // Stop the timer after execution
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<Task> getTaskById(@PathVariable Long id) {
        // Start the timer for this method
        Timer.Sample sample = Timer.start(meterRegistry);
        try {
            Optional<Task> task = taskService.getTaskById(id);
            if (task.isPresent()) {
                getByIdSuccessCounter.increment();  // Increment success counter
                logger.info("200 OK: Retrieved task with id " + id);
                return ResponseEntity.ok(task.get());
            } else {
                logger.warning("404 NOT FOUND: Task with id " + id + " not found");
                return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
            }
        } finally {
            sample.stop(getByIdTimer);  // Stop the timer after execution
        }
    }

    @PostMapping
    public ResponseEntity<?> createTask(@RequestBody Task task) {
        // Start the timer for this method
        Timer.Sample sample = Timer.start(meterRegistry);
        try {
            if (task.getTitle() == null || task.getTitle().isEmpty()) {
                logger.warning("400 BAD REQUEST: Task title is required");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Task title is required");
            }
            Task createdTask = taskService.createTask(task);
            createTaskSuccessCounter.increment();  // Increment success counter
            logger.info("201 CREATED: Task created with id " + createdTask.getId());
            return ResponseEntity.status(HttpStatus.CREATED).body(createdTask);
        } finally {
            sample.stop(createTaskTimer);  // Stop the timer after execution
        }
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
