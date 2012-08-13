using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

namespace WindowsFormsApplication_DoTest
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            DataObjects_Framework.Common.Do_Globals.gSettings.pConnectionString = @"User ID=sa; Password=Administrator1; Initial Catalog=DoTest;Data Source=.\Sql_2k5;";
            DataObjects_Framework.Common.Do_Globals.gSettings.pDataAccessType = DataObjects_Framework.Common.Do_Constants.eDataAccessType.DataAccess_WCF;
            DataObjects_Framework.Common.Do_Globals.gSettings.pUseSoftDelete = false;
            //DataObjects_Framework.Common.Do_Globals.gSettings.pWcfAddress = @"http://localhost/DataObjects_Wcf/WcfService.svc";
            DataObjects_Framework.Common.Do_Globals.gSettings.pWcfAddress = @"http://localhost:4802/WcfService.svc";
            //http://localhost:4802/WcfService.svc

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new Form1());
        }
    }
}
