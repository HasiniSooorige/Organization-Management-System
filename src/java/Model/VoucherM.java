/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.util.Date;

/**
 *
 * @author jalana
 */
public class VoucherM {

    private String vid;
    private String nic;
    private String name;
    private String voucherTotal;
    private String voucherTypeId;
    private String institute;
    private String generalUserProfileId;
    private String description;
    private String paymentMode;
    private String paymentDate;

    public VoucherM() {
    }

    public VoucherM(String vid, String nic, String name, String voucherTotal, String voucherTypeId, String institute, String generalUserProfileId, String loginSessionId, String description, String paymentMode, String paymentDate) {
        this.vid = vid;
        this.nic = nic;
        this.name = name;
        this.voucherTotal = voucherTotal;
        this.voucherTypeId = voucherTypeId;
        this.institute = institute;
        this.generalUserProfileId = generalUserProfileId;
        this.description = description;
        this.paymentMode = paymentMode;
        this.paymentDate = paymentDate;
    }

    public String getVid() {
        return vid;
    }

    public void setVid(String vid) {
        this.vid = vid;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getVoucherTotal() {
        return voucherTotal;
    }

    public void setVoucherTotal(String voucherTotal) {
        this.voucherTotal = voucherTotal;
    }

    public String getVoucherTypeId() {
        return voucherTypeId;
    }

    public void setVoucherTypeId(String voucherTypeId) {
        this.voucherTypeId = voucherTypeId;
    }

    public String getInstitute() {
        return institute;
    }

    public void setInstitute(String institute) {
        this.institute = institute;
    }

 

    public String getGeneralUserProfileId() {
        return generalUserProfileId;
    }

    public void setGeneralUserProfileId(String generalUserProfileId) {
        this.generalUserProfileId = generalUserProfileId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPaymentMode() {
        return paymentMode;
    }

    public void setPaymentMode(String paymentMode) {
        this.paymentMode = paymentMode;
    }

    public String getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(String paymentDate) {
        this.paymentDate = paymentDate;
    }

}
