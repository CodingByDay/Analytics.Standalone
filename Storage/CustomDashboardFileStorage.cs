using DevExpress.DashboardCommon;
using DevExpress.DashboardWeb;
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
            Dashboard dashboard = new Dashboard();
            dashboard.LoadFromXDocument(base.LoadDashboard(dashboardId));
            return dashboard;
        }
     
    }
}
