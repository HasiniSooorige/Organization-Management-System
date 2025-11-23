/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.Mapping.ProjectTasks;
import Model.ProjectTaskM;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author HP
 */
@WebServlet(name = "TaskEditDataView", urlPatterns = {"/TaskEditDataView"})
public class TaskEditDataView extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("____________Task  Edit  Data  View___________");
        String id = request.getParameter("id");
        System.out.println("id  :" + id);
        
        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();
        
        ProjectTasks pt = (ProjectTasks) sess.createQuery("From ProjectTasks Where id='" + id + "'").setMaxResults(1).uniqueResult();
        
        ProjectTaskM ptm = new ProjectTaskM();
        
        if (pt == null) {
            System.out.println("Task Id Not Ok");
        } else {
            
            System.out.println("Task View Id Ok");
            
            ptm.setTaskId(pt.getId());
            ptm.setTaskName(pt.getName());
            ptm.setTaskNote(pt.getNote());
            ptm.setPriorityId(pt.getProjectTaskPriority().getId());
            ptm.setPriorityName(pt.getProjectTaskPriority().getName());
            ptm.setProjectsId(pt.getProjects().getId());
            ptm.setProjectsName(pt.getProjects().getName());
            ptm.setStatusId(pt.getStatus().getId());
            ptm.setStatusName(pt.getStatus().getName());
            ptm.setAssignedDate(pt.getAssignedDate());
            ptm.setDueDate(pt.getDueDate());
            ptm.setStartDate(pt.getStartDate());
            ptm.setCompletedDate(pt.getCompletedDate());
            ptm.setEndDate(pt.getEndDate());
            ptm.setIsActive(pt.getIsActive());
            
            System.out.println("view - task - data");
            
            ObjectMapper mapper = new ObjectMapper();
            mapper.writeValueAsString(ptm);
            System.out.println(mapper.writeValueAsString(ptm));
            response.getWriter().print(mapper.writeValueAsString(ptm));
            
        }
        
    }
    
}
