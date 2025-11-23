<%-- 
    Document   : admin-panel
    Created on : Jul 20, 2023, 11:21:15 AM
    Author     : Nilupul Nethmina
--%>
<%@page import="java.util.List"%>
<%@page import="Model.Mapping.UserLoginHasSystemInterface"%>
<%@page import="Model.Mapping.UserRoleHasSystemInterface"%>
<%@page import="Model.Mapping.SystemInterface"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Logic.UserLoginDAO"%>
<%@page import="Model.Mapping.UserLogin"%>
<%@page import="Model.Connection.NewHibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<style>
    .menu-vertical .app-brand {
        padding-right: 0rem !important;
        padding-left: 0rem !important;
    }
</style>
<aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">


    <%

        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        int ulids = Integer.parseInt((String.valueOf(request.getSession().getAttribute("User_ID"))));
        System.out.println(request.getSession().getAttribute("User_ID"));
        ArrayList<SystemInterface> system_interface_list = new ArrayList();
        UserLogin uls = UserLoginDAO.getByID(sess, ulids);

        String url_dashboard = "";
        if (uls.getUserRole().getId() == 1) {
            url_dashboard = "page-mng-dashboard";
        } else if (uls.getUserRole().getId() == 2) {
            url_dashboard = "page-mng-dashboard";

        } else if (uls.getUserRole().getId() == 3) {
            url_dashboard = "page-emp-dashboard";
        } else if (uls.getUserRole().getId() == 4) {
            url_dashboard = "page-external-dashboard";

        }
    %>
    <div class="app-brand demo">
        <a href="../main-pages/<%=url_dashboard%>.jsp" class="app-brand-link">
            <span class="app-brand-text demo text-body "><img  height="50px;" src="../assets/img/icons/ExonFullLogoCopy.jpg" /></span>
        </a>
    </div>
    <%
        List<UserRoleHasSystemInterface> urhsi_list = sess.createQuery("from UserRoleHasSystemInterface where userRole.id='" + uls.getUserRole().getId() + "'   ORDER BY systemInterface.interfaceMenu.ifId ASC").list();
        List<UserLoginHasSystemInterface> ulhsi_list = sess.createQuery("from UserLoginHasSystemInterface where userLogin.id='" + uls.getId() + "'  ORDER BY  systemInterface.interfaceMenu.ifId ASC").list();
        System.out.println("urhsi_list size :" + urhsi_list.size());
        System.out.println("ulhsi_list size :" + ulhsi_list.size());
        for (UserRoleHasSystemInterface urhsi : urhsi_list) {
            system_interface_list.add(urhsi.getSystemInterface());
        }
        //Collections.sort(arraylist);
        for (UserLoginHasSystemInterface ulhsi : ulhsi_list) {
            system_interface_list.add(ulhsi.getSystemInterface());
        }
        ArrayList<SystemInterface> newList = new ArrayList();
        for (SystemInterface element : system_interface_list) {
            if (!newList.contains(element)) {

                newList.add(element);
            }
        }
        //System.out.println("oldList size " + system_interface_list.size());
        //System.out.println("newList size " + newList.size());

        ArrayList<Integer> arraylist = new ArrayList();
        for (SystemInterface si : newList) {
            arraylist.add(si.getSiId());
        }

        system_interface_list = newList;
        if (!(system_interface_list.isEmpty())) {
            int menuid = 0;

            for (int si1 : arraylist) {
                SystemInterface systemInterface1 = (SystemInterface) sess.createQuery("from SystemInterface where siId='" + si1 + "'").uniqueResult();
                //                    for (SystemInterface systemInterface1 : system_interface_list) {
                if (menuid != systemInterface1.getInterfaceMenu().getIfId()) {
                    if (systemInterface1.getInterfaceSubMenu().getIfsId() == 4) {

    %>


    <li id="dashboard_li" class="nav-item ">
        <a href="../<%= systemInterface1.getUrl()%>" class="nav-link nav-toggle">
            <i class="<%= systemInterface1.getIcon()%>"></i>
            <span class="title"><%= systemInterface1.getDisplayName()%></span>
        </a>
    </li>
    <%
    } else {
    %>
    <div class="menu-inner-shadow"></div>

    <ul class="menu-inner py-1">
        <li class="menu-item ">
            <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="<%= systemInterface1.getInterfaceMenu().getIcon()%>"></i>
                <div data-i18n="Account Settings">&nbsp;<%= systemInterface1.getInterfaceMenu().getMenuName()%></div>
            </a>    
            <ul class="menu-sub" >
                <li class="menu-item">
                    <a href="javascript:void(0);" class="menu-link menu-toggle">
                        <i class="menu-icon tf-icons bx bx-detail"></i>
                        <div data-i18n="Account Settings">Task</div>
                    </a>
                    <ul class="menu-sub">
                        <%
                            for (int si : arraylist) {
                                SystemInterface systemInterface = (SystemInterface) sess.createQuery("from SystemInterface where siId='" + si + "'").uniqueResult();
//                    for (SystemInterface systemInterface : system_interface_list) {
                                if (systemInterface.getInterfaceSubMenu().getIfsId() == 1 && systemInterface.getInterfaceMenu().getMenuName().equals(systemInterface1.getInterfaceMenu().getMenuName())) {%>


                        <li class="menu-item">
                            <a href="../<%= systemInterface.getUrl()%>" class="menu-link">
                                <i class="<%= systemInterface.getIcon()%>"></i>
                                <div data-i18n="Account">&nbsp;<%= systemInterface.getDisplayName()%></div>
                            </a>
                        </li>
                        <%
                                }
                            }
                        %>
                    </ul>
                </li>
                <li class="menu-item">
                    <a href="javascript:void(0);" class="menu-link menu-toggle">
                        <i class="menu-icon tf-icons bx bx-copy"></i>
                        <div data-i18n="Account Settings">Maintain</div>
                    </a>
                    <ul class="menu-sub">
                        <%
                            for (int si : arraylist) {
                                SystemInterface systemInterface = (SystemInterface) sess.createQuery("from SystemInterface where siId='" + si + "'").uniqueResult();
//                    for (SystemInterface systemInterface : system_interface_list) {
                                if (systemInterface.getInterfaceSubMenu().getIfsId() == 3 && systemInterface.getInterfaceMenu().getMenuName().equals(systemInterface1.getInterfaceMenu().getMenuName())) {%>


                        <li class="menu-item">
                            <a href="../<%= systemInterface.getUrl()%>" class="menu-link">
                                <i class="<%= systemInterface.getIcon()%>"> </i>
                                <div data-i18n="Account">&nbsp;<%= systemInterface.getDisplayName()%></div>
                            </a>
                        </li>
                        <%
                                }
                            }
                        %>
                    </ul>
                </li>
                <li class="menu-item">
                    <a href="javascript:void(0);" class="menu-link menu-toggle">
                        <i class="menu-icon tf-icons bx bx-table"></i>
                        <div data-i18n="Account Settings">Reports</div>
                    </a>
                    <ul class="menu-sub">
                        <%
                            for (int si : arraylist) {
                                SystemInterface systemInterface = (SystemInterface) sess.createQuery("from SystemInterface where siId='" + si + "'").uniqueResult();
                                if (systemInterface.getInterfaceSubMenu().getIfsId() == 2 && systemInterface.getInterfaceMenu().getMenuName().equals(systemInterface1.getInterfaceMenu().getMenuName())) {
                        %>
                        <li class="menu-item">
                            <a href="../<%= systemInterface.getUrl()%>" class="menu-link">
                                <i class="<%= systemInterface.getIcon()%>"></i>
                                <div data-i18n="Alluserprofile">&nbsp;<%= systemInterface.getDisplayName()%></div>
                            </a>
                        </li>
                        <%
                                }
                            }
                        %>
                    </ul>
                </li>
            </ul>
        </li>




        <%
                        }
                    }
                    menuid = systemInterface1.getInterfaceMenu().getIfId();
                }

            }
        %>

        <!--Employee-->  
        <!--        <li class="heading">
                    <h3 class="uppercase">Maintenance</h3>
                </li>
                <li class="nav-item  ">
                    <a href="../main-pages/password-change-employee.jsp" class="nav-link nav-toggle">
                        <i class=" fa fa-key"></i>
                        <span class="title">Change Password</span>
                    </a>
                </li>-->
    </ul>

</aside>
