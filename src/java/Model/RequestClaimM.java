/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.util.Date;

/**
 *
 * @author Suren Fernando
 */
public class RequestClaimM {

    private Integer id;
    private Integer claimId;
    private Date date;
    private Double amount;
    private String reason;
    private String fileUrl;
    
    public RequestClaimM(){
    }

    public RequestClaimM(Integer id, Integer claimId, Date date, Double amount, String reason, String fileUrl) {
        this.id = id;
        this.claimId = claimId;
        this.date = date;
        this.amount = amount;
        this.reason = reason;
        this.fileUrl = fileUrl;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getClaimId() {
        return claimId;
    }

    public void setClaimId(Integer claimId) {
        this.claimId = claimId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }
    
    

}
