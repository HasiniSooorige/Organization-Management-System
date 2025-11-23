/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

/**
 *
 * @author Jalana
 */
public class EmployeeDocumentsM {

    public EmployeeDocumentsM() {
    }
    private Integer id;
    private String url;
    private String name;
    private Integer documenttypeid;
    private String documenttypename;
    private Integer employeeid;
    private Integer docSizeN;
    private Integer docSizeB;
    private Integer docSizeE;

    public EmployeeDocumentsM(Integer id, String url, String name, Integer documenttypeid, String documenttypename, Integer employeeid, Integer docSizeN, Integer docSizeB, Integer docSizeE) {
        this.id = id;
        this.url = url;
        this.name = name;
        this.documenttypeid = documenttypeid;
        this.documenttypename = documenttypename;
        this.employeeid = employeeid;
        this.docSizeN = docSizeN;
        this.docSizeB = docSizeB;
        this.docSizeE = docSizeE;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getDocumenttypeid() {
        return documenttypeid;
    }

    public void setDocumenttypeid(Integer documenttypeid) {
        this.documenttypeid = documenttypeid;
    }

    public String getDocumenttypename() {
        return documenttypename;
    }

    public void setDocumenttypename(String documenttypename) {
        this.documenttypename = documenttypename;
    }

    public Integer getEmployeeid() {
        return employeeid;
    }

    public void setEmployeeid(Integer employeeid) {
        this.employeeid = employeeid;
    }

    public Integer getDocSizeN() {
        return docSizeN;
    }

    public void setDocSizeN(Integer docSizeN) {
        this.docSizeN = docSizeN;
    }

    public Integer getDocSizeB() {
        return docSizeB;
    }

    public void setDocSizeB(Integer docSizeB) {
        this.docSizeB = docSizeB;
    }

    public Integer getDocSizeE() {
        return docSizeE;
    }

    public void setDocSizeE(Integer docSizeE) {
        this.docSizeE = docSizeE;
    }

}
