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
import Model.Mapping.Country;
import Model.Mapping.Employee;
import Model.Mapping.GeneralUserProfile;
import Model.Connection.NewHibernateUtil;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Transaction;
import org.hibernate.Session;
import org.hibernate.id.IdentifierGenerator;

/**
 *
 * @author kbnc
 */
public  class EmployeetIdGenerator {
   
    static int newEmpNumber;
    
    public static Integer IdGenerator(List empL){
        
          Session hibSession = NewHibernateUtil.getSessionFactory().openSession();
   Transaction tx = hibSession.beginTransaction();
   try{
       Query q = hibSession.createQuery("select max(emp.epfNo) from Employee as emp");           
       //doens't work (gives an error :invalid alias "emp")
       //q.setLockMode("emp",LockMode.UPGRADE);
       //
       String emplast = (String)q.uniqueResult();

        newEmpNumber = Integer.parseInt(emplast) + 1;
       for(Iterator <Employee>it=empL.iterator();
               it.hasNext();){
          Employee emp = it.next();
          emp.setEpfNo(emplast);
           System.out.println("new_emp");
           System.out.println(""+newEmpNumber);
        
//          hibSession.saveOrUpdate(emp);

//          newEmpNumber;      
       }
      
//       tx.commit();
   }catch (HibernateException he) {
       tx.rollback();
       throw he;
   }finally {
       hibSession.close();
   }  
   
   return newEmpNumber;
    
    }
}