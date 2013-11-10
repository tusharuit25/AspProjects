using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NewEventManager
{
    public class TwitterLink
    {

        private int _id;
        private string _twitterlink;
        private string eventCode;
        private string _twitterID;

        public TwitterLink()
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
        public string EventCode
        {
            get { return eventCode; }
            set { eventCode = value; }
        }
        public string Twitterlink
        {
            get { return _twitterlink; }
            set { _twitterlink = value; }
        }
        public string TwitterID
        {
            get { return _twitterID; }
            set { _twitterID = value; }
        }
        

    }
}