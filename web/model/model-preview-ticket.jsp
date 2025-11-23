<%-- 
    Document   : model-preview-news
    Created on : Oct 25, 2022, 12:10:45 PM
    Author     : sachintha
--%>

<%@page import="Model.Connection.NewHibernateUtil"%>
<%@page import="Model.Mapping.HelpTicketAttachments"%>
<%@page import="Model.Mapping.HelpTicket"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Model.CommonMethod.Com"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<style>
    /*================================================
News Details Area CSS
=================================================*/
    .blog-details-desc .article-image {
        position: relative;
    }

    .blog-details-desc .article-image i {
        font-size: 100px;
        position: absolute;
        top: 50%;
        -webkit-transform: translateY(-50%);
        transform: translateY(-50%);
        left: 0;
        right: 0;
        color: #ffffff;
        -webkit-transition: 0.5s;
        transition: 0.5s;
        text-align: center;
    }

    .blog-details-desc .article-image:hover i {
        color: #683BDE;
    }

    .blog-details-desc .article-content {
        margin-top: 30px;
    }

    .blog-details-desc .article-content span {
        font-weight: 400;
        font-size: 14px;
    }

    .blog-details-desc .article-content span a {
        color: #656565;
    }

    .blog-details-desc .article-content span a:hover {
        color: #683BDE;
    }

    .blog-details-desc .article-content h3 {
        margin-top: 20px;
        margin-bottom: 15px;
        font-size: 35px;
    }

    .blog-details-desc .article-content h4 {
        margin-bottom: 15px;
        font-size: 25px;
    }

    .blog-details-desc .article-content p {
        font-size: 15px;
        font-weight: 400;
    }

    .blog-details-desc .article-content .features-list {
        padding-left: 0;
        list-style-type: none;
        margin-top: 20px;
        margin-bottom: 30px;
    }

    .blog-details-desc .article-content .features-list li {
        margin-bottom: 16px;
        position: relative;
        padding-left: 34px;
        color: #656565;
    }

    .blog-details-desc .article-content .features-list li i {
        width: 25px;
        height: 25px;
        line-height: 25px;
        text-align: center;
        border-radius: 40px;
        background-color: #faf5f5;
        color: #dc472e;
        -webkit-transition: 0.5s;
        transition: 0.5s;
        display: inline-block;
        font-size: 20px;
        position: absolute;
        left: 0;
        top: -2px;
    }

    .blog-details-desc .article-content .features-list li:hover i {
        background-color: #dc472e;
        color: #ffffff;
    }

    .blog-details-desc .article-content .features-list li:last-child {
        margin-bottom: 0;
    }

    .blog-details-desc .article-content .desc-overview {
        margin-top: 30px;
        margin-bottom: 30px;
    }



    /*//card view*/

    .container {
        display: flex;
        flex-direction: column;

    }

    .event-item {
        position: relative;
        margin-top: 50px;
        width: 100%;
        height: 560px;
        box-shadow: none;   
        transition: box-shadow 0.5s ease-in-out;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.15), 0 3px 3px rgba(0, 0, 0, 0.15);
    }
    .carddiv{
        margin: auto;
    }
    @media (min-width: 1340px) and (max-width: 5200px) {
        .event-item{ 
            background: #fff;
            margin-top: 50px;
            width: 280px;
            height: 600px;
        }
        .carddiv{
            width: 1380px;
        }

    }
    @media (max-width: 991px){
        .event-item {
            margin-top: 50px;
            height: 700px;
        }
        .carddiv{
            padding: 50px;
        }

    }
    .event-item:hover {
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
    }


    .event-item .thumb{
        overflow: hidden;
    }
    .event-item .thumb img{
        width: 100%;
        height: 280px;
        object-fit: cover;
    } 


    @media (min-width: 1340px) and (max-width: 5200px) {
        .event-item .thumb img{
            height: 300px;
        }
        .event-item {
            height: 580px;
            padding-bottom: 100px;
        }
        .carddiv{
            width: 1500px;
        }
    }
    @media (max-width: 991px){
        .event-item .thumb img{
            height: 350px;
        }}
    .event-content{
        padding: 30px;
        background: #ffffff;
        position: relative;
        height: 50%;
        cursor: pointer;
        /*    /transition: all 0.6s ease 0.6s;/
            box-shadow: none;   
            /transition: all 0.5s ease-in, all 0.5s ease-out;/
            transition: box-shadow 0.3s ease;*/

    }
    /* .event-item:hover .event-content{
        background:  #040f2b;
        color: #96bece;
    } */

    .event-item p{
        color: #040f2b;
        font-weight: bold;

    }

    .event-item:hover p{
        color: #0693e3;
        font-weight: bold;

    }
    /*.event-item:hover {
         background: #040f2b; 
         color: #96bece; 
        color: #0693e3;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.20), 0 5px 5px rgba(0, 0, 0, 0.17);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); 
         height: 250px; 
    }*/



    /* .event-item:hover .event-content .time{
        color: #bbeafe;
    } */
    .event-item:hover .event-content .time{
        color:  #3bdec3;
    }

    /* .event-item:hover .event-content .time strong,.event-item:hover .event-content h3 a{
      color: #ffbe00; 
    }   */



    .event-content h3 a{
        color: #ffbe00;
        font-family: 'Jost', sans-serif;
        font-weight: lighter;

    }
    .event02 .event-content h3{
        font-size: 24px;
    }

    .event-content .date {
        margin-top: 20px;
    } 

    .event-content .date {
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.15), 0 3px 3px rgba(0, 0, 0, 0.15);
        position: absolute;
        background-color: #ffbe00;

        /* width: 87px; */
        width: 74px;
        /* height: 67px; */
        height: 76px;
        left: 30px;
        top: -60px;
        color: #fff;
        text-align: center;
        font-size: 16px;
        font-family: 'Jost', sans-serif;
    }


    .event-content .date strong{
        font-size: 24px;
        display: block;
        margin-top: 3px;
    }
    .event-content .date small{
        font-size: 16px;
        display: block;
        margin-top: 10px;
        font-family: 'Jost', sans-serif;
        font-style: light;
    }
    /* .event-content h3{
        font-size: 24px;
    } */

    .event-content h3{
        font-size: 14px;
        text-transform: uppercase;
        margin-top: 20px;
    }
    .event-content p{
        font-size: 18px;
        transition: color 0.3s ease-in-out;
    }
    .event-content p:hover{
        color: #0057FF;

    }
    .event-content .time{
        font-family: 'Jost', sans-serif;
    }
    /* .event-content .time strong{
        font-weight: 500;
        color: #ffbe00;
    } */
    .event-content .time strong{
        font-weight: 500;
        color: #ffbe00;
    }
    .event-content .time i{
        margin-left: 5px;
        margin-right: 5px;
    }
    .event02 .event-item{
        width: 100%;
        float: left;
    }
    .event02 .thumb {
        width: 219px;
        height: 270px;
        float: left;
    }
    .event02 .event-content {
        float: left;
        width: 59%;
    }
    .event02 .event-content .date{
        position: relative;
        left: inherit;
        top: inherit;
        display: inline-block;
        margin-bottom: 20px;
    }
    .event02 .thumb {
        width: 219px;
        height: 277px;
    }
    .event02 .thumb img{
        width: 219px;
        height: 277px;
    }
    .event02 .event-content .date{
        border-radius: 4px;
        margin-bottom: 20px;
    }
    .event02 .event-content .icon {
        position: absolute;
        right: 30px;
        top: 0;
        font-size: 90px;
        color: #dfeeff;
    }
    .event03 .event-content,.event03 .event-item{
        float: left;
    }
    /* .event03 .event-content{
        background: #fff;
        border: 1px solid #ffbe00;
        padding: 30px;
    } */
    .event03 .event-content{
        background: #fff;
        border: 1px solid #ffbe00;
        padding: 30px;
    }
    .event03 .event-content h3{
        font-size: 24px;
    }
    .event03 .event-content .date{
        position: relative;
        top: 0;
        left: 0;
        float: left;
        border-radius: 4px;
        height: 80px;
        padding-top: 6px;
    }
    .event03 .event-content .icon {
        position: absolute;
        right: 30px;
        top: 0;
        font-size: 90px;
        color: #f7f9ff;

    }
    .event03 .event-content .text {
        float: left;
        width: 81%;
        margin-left: 20px;
    }
    /* .event03 .event-item:hover .icon {
        color: #356c84;
    } */
    .event03 .event-item:hover .icon {
        color: #040f2b;
    }
    /* .event03 .event-content .time i{
        color: #ffbe00;
    } */
    .event03 .event-content .time i{
        color: #ffbe00;
    }
    .event03 .event-content .time strong {
        font-weight: 500;
        color: #777;
    }

</style>




<div class="" style="">
    <div class="row">

        <div class="col-md-12 col-lg-12"  style=" justify-content: center; ">
            <%
                Session sess = NewHibernateUtil.getSessionFactory().openSession();
                if (session.getAttribute("User_ID") != null) {
                    int nid = Integer.valueOf(request.getParameter("id").toString());
                    System.out.println("t id " + nid);
                    HelpTicket n = (HelpTicket) sess.load(HelpTicket.class, nid);
                    System.out.println("id " + nid);
                    System.out.println("t " + n.getTicketId());
                    List<HelpTicketAttachments> t_list = sess.createQuery("from HelpTicketAttachments where helpTicket.id='" + n.getId() + "' order by id ASC  ").list();
                    if (t_list != null) {

                        for (HelpTicketAttachments hta : t_list) {

            %>


            <div class="col-md-3" style=" display: flex; justify-content: center;">
                <div id="upcomingdiv" class=""  data-animation="fadeInUp" data-delay=".6s">
                    <div class="event-item ">
                        <div class="thumb">
                            <p style="color: #000066;">
                                <%=Com.getDate(hta.getHelpTicket().getEnteredDate())%><br/>
                                BY:  <%=hta.getHelpTicket().getRequestedBy()%>
                            </p>
                            <img
                                src="../UploadTicket?getfile=<%= hta.getUrl()%>"
                                alt="image" >
                        </div>                   
                    </div>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <label for="form_control_1"><span class="fw-light">There is no attachments </span></label>
            <%
                }
            %>
        </div>
    </div>
</div>

<%    } else {
        response.sendRedirect("../index.jsp");
    }
%>
