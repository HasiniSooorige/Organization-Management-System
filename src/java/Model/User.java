/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.io.Serializable;

/**
 *
 * @author kbnc
 */

public class User implements Serializable {
  private int accountId;
  private String loginId;
  private Role type;

  public User(int accountId, String loginId, Role type) {
    this.accountId = accountId;
    this.loginId = loginId;
    this.type = type;
  }

  public User() {
    this.accountId = -1;
    this.loginId = null;
    this.type = null;
  }

  public void setRole(Role type) {
    this.type = type;
  }

  public Role getRole() {
    return this.type;
  }

  public void setAccountId(int accountId) {
    this.accountId = accountId;
  }

  public int getAccountId() {
    return this.accountId;
  }

  public void setLoginId(String loginId) {
    this.loginId = loginId;
  }

  public String getLoginId() {
    return this.loginId;
  }
}