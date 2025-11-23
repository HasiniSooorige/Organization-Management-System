/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.util.Date;

/**
 *
 * @author HP
 */
public class ProjectTaskM {

    private Integer taskId;
    private Integer priorityId;
    private String priorityName;
    private Integer projectsId;
    private String projectsName;
    private Integer statusId;
    private String statusName;
    private String taskName;
    private String taskNote;
    private Date assignedDate;
    private Date dueDate;
    private Date startDate;
    private Date completedDate;
    private Date endDate;
    private Boolean isActive;
    private String url;

    public ProjectTaskM() {
    }

    public ProjectTaskM(Integer taskId, Integer priorityId, String priorityName, Integer projectsId, String projectsName, Integer statusId, String statusName, String taskName, String taskNote, Date assignedDate, Date dueDate, Date startDate, Date completedDate, Date endDate, Boolean isActive, String url) {
        this.taskId = taskId;
        this.priorityId = priorityId;
        this.priorityName = priorityName;
        this.projectsId = projectsId;
        this.projectsName = projectsName;
        this.statusId = statusId;
        this.statusName = statusName;
        this.taskName = taskName;
        this.taskNote = taskNote;
        this.assignedDate = assignedDate;
        this.dueDate = dueDate;
        this.startDate = startDate;
        this.completedDate = completedDate;
        this.endDate = endDate;
        this.isActive = isActive;
        this.url = url;
    }

    public Integer getTaskId() {
        return taskId;
    }

    public void setTaskId(Integer taskId) {
        this.taskId = taskId;
    }

    public Integer getPriorityId() {
        return priorityId;
    }

    public void setPriorityId(Integer priorityId) {
        this.priorityId = priorityId;
    }

    public String getPriorityName() {
        return priorityName;
    }

    public void setPriorityName(String priorityName) {
        this.priorityName = priorityName;
    }

    public Integer getProjectsId() {
        return projectsId;
    }

    public void setProjectsId(Integer projectsId) {
        this.projectsId = projectsId;
    }

    public String getProjectsName() {
        return projectsName;
    }

    public void setProjectsName(String projectsName) {
        this.projectsName = projectsName;
    }

    public Integer getStatusId() {
        return statusId;
    }

    public void setStatusId(Integer statusId) {
        this.statusId = statusId;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public String getTaskNote() {
        return taskNote;
    }

    public void setTaskNote(String taskNote) {
        this.taskNote = taskNote;
    }

    public Date getAssignedDate() {
        return assignedDate;
    }

    public void setAssignedDate(Date assignedDate) {
        this.assignedDate = assignedDate;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getCompletedDate() {
        return completedDate;
    }

    public void setCompletedDate(Date completedDate) {
        this.completedDate = completedDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

}
