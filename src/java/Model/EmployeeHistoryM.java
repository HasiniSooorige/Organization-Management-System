/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

/**
 *
 * @author kbnc
 */
public class EmployeeHistoryM {
    
    private String epfno;

    public EmployeeHistoryM(String epfno, String deignation, String nic, String mobileno, String datefrom, String dateto, String designationto, String designationfrom) {
        this.epfno = epfno;
        this.deignation = deignation;
        this.nic = nic;
        this.mobileno = mobileno;
        this.datefrom = datefrom;
        this.dateto = dateto;
        this.designationto = designationto;
        this.designationfrom = designationfrom;
    }

    public EmployeeHistoryM() {
    }
private String deignation;
private String nic;
private String mobileno;
private String datefrom;
private String dateto;
private String designationto;
private String designationfrom;

    public String getEpfno() {
        return epfno;
    }

    public void setEpfno(String epfno) {
        this.epfno = epfno;
    }

    public String getDeignation() {
        return deignation;
    }

    public void setDeignation(String deignation) {
        this.deignation = deignation;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }

    public String getMobileno() {
        return mobileno;
    }

    public void setMobileno(String mobileno) {
        this.mobileno = mobileno;
    }

    public String getDatefrom() {
        return datefrom;
    }

    public void setDatefrom(String datefrom) {
        this.datefrom = datefrom;
    }

    public String getDateto() {
        return dateto;
    }

    public void setDateto(String dateto) {
        this.dateto = dateto;
    }

    public String getDesignationto() {
        return designationto;
    }

    public void setDesignationto(String designationto) {
        this.designationto = designationto;
    }

    public String getDesignationfrom() {
        return designationfrom;
    }

    public void setDesignationfrom(String designationfrom) {
        this.designationfrom = designationfrom;
    }
    
}
