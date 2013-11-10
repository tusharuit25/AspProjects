using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NewEventManager
{
    public class SpeakerToSession
    {
        private int _id;
        private int _speakerid;
        private int _sessionid;


        public SpeakerToSession()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public int ID
        {
            get { return _id; }
            set { _id = value; }
        }
        public int SpeakerId
        {
            get { return _speakerid; }
            set { _speakerid = value; }
        }
        public int SessionId
        {
            get { return _sessionid; }
            set { _sessionid = value; }
        }  
    }
}