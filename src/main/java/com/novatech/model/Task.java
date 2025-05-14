package com.novatech.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Task {
    private int taskId;
    private int userId;
    private String title;
    private String description;
    private TaskStatus status;
    private PriorityLevel priority;
    private Date dueDate;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public enum TaskStatus{
        PENDING, IN_PROGRESS, COMPLETED
    }

    public enum PriorityLevel{
        LOW, MEDIUM, HIGH
    }

    public Task(){}

    public Task(int taskId, int userId, String title, String description, TaskStatus status, PriorityLevel priority, Date dueDate, Timestamp createdAt, Timestamp updatedAt) {
        this.taskId = taskId;
        this.userId = userId;
        this.title = title;
        this.description = description;
        this.status = status;
        this.priority = priority;
        this.dueDate = dueDate;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getTaskId() {
        return taskId;
    }

    public void setTaskId(int taskId) {
        this.taskId = taskId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public TaskStatus getStatus() {
        return status;
    }

    public void setStatus(TaskStatus status) {
        this.status = status;
    }

    public PriorityLevel getPriority() {
        return priority;
    }

    public void setPriority(PriorityLevel priority) {
        this.priority = priority;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}
