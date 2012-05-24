using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataObjects_Framework;
using DataObjects_Framework.Base;
using DataObjects_Framework.Common;

namespace WindowsFormsApplication_DoTest.DataObjects
{
    public class Employee_Salary : ClsBase_List
    {
        public Employee_Salary()
        {
            this.Setup("Employee_Salary", "", new List<string>() { "ID" });
        }        
    }
}
