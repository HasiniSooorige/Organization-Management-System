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
public class CommentManagerM {

    private int commentManagerId;

    private int generalUserProfileId;
    private String gupFirstName;
    private String gupLastName;
    private String gupFirstNameEMP;
    private String gupLastNameEMP;

    private int projectTaskId;
    private String projectTaskName;

    private int projectId;
    private String projectName;

    private String comment;
    private Date addedDate;

    public CommentManagerM() {
    }

    public CommentManagerM(int commentManagerId, int generalUserProfileId, String gupFirstName, String gupLastName, String gupFirstNameEMP, String gupLastNameEMP, int projectTaskId, String projectTaskName, int projectId, String projectName, String comment, Date addedDate) {
        this.commentManagerId = commentManagerId;
        this.generalUserProfileId = generalUserProfileId;
        this.gupFirstName = gupFirstName;
        this.gupLastName = gupLastName;
        this.gupFirstNameEMP = gupFirstNameEMP;
        this.gupLastNameEMP = gupLastNameEMP;
        this.projectTaskId = projectTaskId;
        this.projectTaskName = projectTaskName;
        this.projectId = projectId;
        this.projectName = projectName;
        this.comment = comment;
        this.addedDate = addedDate;
    }

    public int getCommentManagerId() {
        return commentManagerId;
    }

    public void setCommentManagerId(int commentManagerId) {
        this.commentManagerId = commentManagerId;
    }

    public int getGeneralUserProfileId() {
        return generalUserProfileId;
    }

    public void setGeneralUserProfileId(int generalUserProfileId) {
        this.generalUserProfileId = generalUserProfileId;
    }

    public String getGupFirstName() {
        return gupFirstName;
    }

    public void setGupFirstName(String gupFirstName) {
        this.gupFirstName = gupFirstName;
    }

    public String getGupLastName() {
        return gupLastName;
    }

    public void setGupLastName(String gupLastName) {
        this.gupLastName = gupLastName;
    }

    public String getGupFirstNameEMP() {
        return gupFirstNameEMP;
    }

    public void setGupFirstNameEMP(String gupFirstNameEMP) {
        this.gupFirstNameEMP = gupFirstNameEMP;
    }

    public String getGupLastNameEMP() {
        return gupLastNameEMP;
    }

    public void setGupLastNameEMP(String gupLastNameEMP) {
        this.gupLastNameEMP = gupLastNameEMP;
    }

    public int getProjectTaskId() {
        return projectTaskId;
    }

    public void setProjectTaskId(int projectTaskId) {
        this.projectTaskId = projectTaskId;
    }

    public String getProjectTaskName() {
        return projectTaskName;
    }

    public void setProjectTaskName(String projectTaskName) {
        this.projectTaskName = projectTaskName;
    }

    public int getProjectId() {
        return projectId;
    }

    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getAddedDate() {
        return addedDate;
    }

    public void setAddedDate(Date addedDate) {
        this.addedDate = addedDate;
    }

}
