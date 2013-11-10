using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NewEventManager
{
    public class ExhibitorFavorite
    {
        public ExhibitorFavorite()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        private int _id;
        private int _attendeeid;
        private string _ucode;
        private string _flag;


        public int ID
        {
            get { return _id; }
            set { _id = value; }
        }
        public int ExhibitorId
        {
            get { return _attendeeid; }
            set { _attendeeid = value; }
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