
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Logic;

import Model.Mapping.InterfaceMenu;
import Model.Mapping.InterfaceSubMenu;
import Model.Mapping.SystemInterface;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author sameera
 */
public class SystemInterfaceDAO {

    public static SystemInterface getByID(Session session, int id) {
        try {
            SystemInterface acc = (SystemInterface) session.load(SystemInterface.class, id);
            return acc;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static SystemInterface getByQuery(Session session, String condition, String orderBy) {
        try {
            StringBuffer sb = new StringBuffer("From SystemInterface as SystemInterface");

            sb.append(" Where ").append(condition);

            if (orderBy != null) {
                sb.append(" Order By ").append(orderBy);
            }

            return (SystemInterface) session.createQuery(sb.toString()).setMaxResults(1).uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static List<SystemInterface> listByQuery(Session session, String condition, String orderBy) {
        StringBuffer sb = new StringBuffer("From SystemInterface as SystemInterface");
        if (condition != null) {
            sb.append(" Where ").append(condition);
        }
        if (orderBy != null) {
            sb.append(" Order By ").append(orderBy);
        }
        try {
            List<SystemInterface> list = session.createQuery(sb.toString()).list();
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static java.util.Iterator iterateByQuery(Session session, String condition, String orderBy) {
        StringBuffer sb = new StringBuffer("From SystemInterface as SystemInterface");
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

    public static SystemInterface save(Session session, String name, String InterfaceName, InterfaceMenu interfaceMenu, InterfaceSubMenu interfaceSubMenu) {
        try {
            SystemInterface al = new SystemInterface();
            al.setDisplayName(name);
            al.setInterfaceMenu(interfaceMenu);
            al.setInterfaceName(InterfaceName);
            al.setInterfaceSubMenu(interfaceSubMenu);
            al.setUrl(name);
            session.save(al);
            return al;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean update(Session session, SystemInterface al, String name, String url, String InterfaceName, InterfaceMenu interfaceMenu, InterfaceSubMenu interfaceSubMenu) {
        try {
            al.setDisplayName(name);
            al.setInterfaceMenu(interfaceMenu);
            al.setInterfaceName(InterfaceName);
            al.setInterfaceSubMenu(interfaceSubMenu);
            al.setUrl(url);
            session.update(al);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean delete(Session session, SystemInterface al) {
        try {
            session.delete(al);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
