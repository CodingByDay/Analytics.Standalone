using DevExpress.DashboardCommon;
using DevExpress.DashboardWeb;
using System;
using System.IO;
using System.Xml.Linq;

namespace Storages {

    public class CustomDashboardFileStorage : DashboardFileStorage {
        public CustomDashboardFileStorage(string workingDirectory)
            : base(workingDirectory) {
        }

        public void DeleteDashboard(string dashboardID) {
            var dashboardPath = base.ResolveFileName(dashboardID);
            if (File.Exists(dashboardPath))
                File.Delete(dashboardPath);
        }



        public Dashboard GetDashboardById(string dashboardId) {
            try
            {
                Dashboard dashboard = new Dashboard();
                dashboard.LoadFromXDocument(base.LoadDashboard(dashboardId));
                return dashboard;
            } catch
            {
                return new Dashboard();
            }
        }

        public void SaveToXMLFile(Dashboard dashboard)
        {
            try
            {
                string fileName = dashboard.CustomProperties.GetValue("DashboardFileName");
                var dashboardPath = base.ResolveFileName(fileName);
                dashboard.SaveToXml(dashboardPath);
            } catch
            {
                return;
            }
        }

        
    }
}
