/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.util.Date;

/**
 *
 * @author Jalana
 */
public class NotificationManageryM {

    private Integer id;
    private String description;
    private Integer employeeid;
    private String notificationtypeid;
    private Boolean isviewed;
    private Date viewddate;
    private Integer referance;

    private Date notifydate;

    public NotificationManageryM(Integer id, String description, Integer employeeid, String notificationtypeid, Boolean isviewed, Date viewddate, Integer referance, Date notifydate) {
        this.id = id;
        this.description = description;
        this.employeeid = employeeid;
        this.notificationtypeid = notificationtypeid;
        this.isviewed = isviewed;
        this.viewddate = viewddate;
        this.referance = referance;
        this.notifydate = notifydate;
    }

    public NotificationManageryM() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getEmployeeid() {
        return employeeid;
    }

    public void setEmployeeid(Integer employeeid) {
        this.employeeid = employeeid;
    }

    public String getNotificationtypeid() {
        return notificationtypeid;
    }

    public void setNotificationtypeid(String notificationtypeid) {
        this.notificationtypeid = notificationtypeid;
    }

    public Boolean getIsviewed() {
        return isviewed;
    }

    public void setIsviewed(Boolean isviewed) {
        this.isviewed = isviewed;
    }

    public Date getViewddate() {
        return viewddate;
    }

    public void setViewddate(Date viewddate) {
        this.viewddate = viewddate;
    }

    public Integer getReferance() {
        return referance;
    }

    public void setReferance(Integer referance) {
        this.referance = referance;
    }

    public Date getNotifydate() {
        return notifydate;
    }

    public void setNotifydate(Date notifydate) {
        this.notifydate = notifydate;
    }

}
