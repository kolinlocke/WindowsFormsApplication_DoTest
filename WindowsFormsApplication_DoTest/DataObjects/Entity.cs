using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataObjects_Framework;
using DataObjects_Framework.Base;
using DataObjects_Framework.Common;

namespace WindowsFormsApplication_DoTest.DataObjects
{
    public abstract class Entity : ClsBase
    {
        object User;

        public void Setup(string TableName, string ViewName, Object User, List<string> CustomKeys = null)
        {
            base.Setup(TableName, ViewName, CustomKeys);
            this.User = User;
        }

    }
}
