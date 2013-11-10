using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NewEventManager
{
    public class SessionFavorite
    {
        public SessionFavorite()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        private int _id;
        private int _sessionid;
        private string _ucode;
        private string _flag;


        public int ID
        {
            get { return _id; }
            set { _id = value; }
        }
        public int SessionId
        {
            get { return _sessionid; }
            set { _sessionid = value; }
        }
        public string Ucode
        {
            get { return _ucode; }
            set { _ucode = value; }
        }

        public string Flag
        {
            get { return _flag; }
            set { _flag = value; }
        }
    }
}