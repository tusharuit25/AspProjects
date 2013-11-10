using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NewEventManager
{
    public class SpeakerMessage
    {
        public SpeakerMessage()
        {
            //
            // TODO: Add constructor logic here
            //
        }


        private int _id;
        private int _fromid;
        private int _toid;
        private string _messageText, _messageDate;
        private string _flag;


        public int ID
        {
            get { return _id; }
            set { _id = value; }
        }
        public int FromId
        {
            get { return _fromid; }
            set { _fromid = value; }
        }
        public int ToId
        {
            get { return _toid; }
            set { _toid = value; }
        }
        public string MessageText
        {
            get { return _messageText; }
            set { _messageText = value; }
        }
    
        public string MessageDate
        {
            get { return _messageDate; }
            set { _messageDate = value; }
        }
        public string Flag
        {
            get { return _flag; }
            set { _flag = value; }
        }
    }
}