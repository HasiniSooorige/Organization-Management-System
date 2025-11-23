/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Logic;

import Model.Mapping.InterfaceSubMenu;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author sameera
 */
public class InterfaceSubMenuDAO {

    public static InterfaceSubMenu getByID(Session session, int id) {
        try {
            InterfaceSubMenu acc = (InterfaceSubMenu) session.load(InterfaceSubMenu.class, id);
            return acc;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static InterfaceSubMenu getByQuery(Session session, String condition, String orderBy) {
        try {
            StringBuffer sb = new StringBuffer("From InterfaceSubMenu as InterfaceSubMenu");

            sb.append(" Where ").append(condition);

            if (orderBy != null) {
                sb.append(" Order By ").append(orderBy);
            }

            return (InterfaceSubMenu) session.createQuery(sb.toString()).setMaxResults(1).uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static List<InterfaceSubMenu> listByQuery(Session session, String condition, String orderBy) {
        StringBuffer sb = new StringBuffer("From InterfaceSubMenu as InterfaceSubMenu");
        if (condition != null) {
            sb.append(" Where ").append(condition);
        }
        if (orderBy != null) {
            sb.append(" Order By ").append(orderBy);
        }
        try {
            List<InterfaceSubMenu> list = session.createQuery(sb.toString()).list();
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static java.util.Iterator iterateByQuery(Session session, String condition, String orderBy) {
        StringBuffer sb = new StringBuffer("From InterfaceSubMenu as InterfaceSubMenu");
        if (condition != null) {
            sb.append(" Where ").append(condition);
        }
        if (orderBy != null) {
            sb.append(" Order By ").append(orderBy);
        }
        try {
            Query query = session.createQuery(sb.toString());
            return query.iterate();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static InterfaceSubMenu save(Session session, String name) {
        try {
            InterfaceSubMenu al = new InterfaceSubMenu();
            al.setName(name);
            session.save(al);
            return al;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean update(Session session, InterfaceSubMenu al, String name) {
        try {
            al.setName(name);
            session.update(al);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean delete(Session session, InterfaceSubMenu al) {
        try {
            session.delete(al);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
