﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using DevExpress.DashboardWeb;
using System.Data.SqlClient;
using System.Data;
using static peptak.SiteMaster;
namespace peptak
{
    public partial class _Default : Page
    {
        private SqlConnection conn;
        private SqlCommand cmd;
        private string userRole;
        private object userName;

        protected void Page_Load(object sender, EventArgs e)
        {

        




              ASPxDashboard1.SetConnectionStringsProvider(new DevExpress.DataAccess.Web.ConfigFileConnectionStringsProvider());
           
       
                ASPxDashboard1.WorkingMode = WorkingMode.Viewer;

        

        }

      

        protected void cmdSignOut_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("logon.aspx", true);

        }


       
    }
}