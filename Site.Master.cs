﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data.SqlClient;

namespace peptak
{
    public partial class SiteMaster : MasterPage
    {
        private SqlCommand cmd;
        private string userRole;
        private SqlConnection conn;
        public static string mode;


        protected void Page_Load(object sender, EventArgs e)
        {
            string UserNameForCheckingAdmin = HttpContext.Current.User.Identity.Name; /* For checking admin permission. */
            conn = new SqlConnection("server=10.100.100.25\\SPLAHOST;Database=petpakDash;Integrated Security=false;User ID=petpakn;Password=net123tnet2!;");
            conn.Open();
            CheckBox checkBox = (CheckBox)FindControl("daynight");

            // Create SqlCommand to select pwd field from users table given supplied userName.
            cmd = new SqlCommand($"Select userRole from Users where uname='{UserNameForCheckingAdmin}';", conn); /// Intepolation or the F string. C# > 5.0       
            // Execute command and fetch pwd field into lookupPassword string.
            userRole = (string)cmd.ExecuteScalar();
            //Button btn = (Button)FindControl("hidden");
            //btn.Click += Btn_Click;
        }




      

        protected void cmdSignOut_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("logon.aspx", true);

        }
    
        protected void administration_Click(object sender, EventArgs e)
        {
            //pass
            Response.Redirect("administration.aspx", true);
          

        }

   
    }
}