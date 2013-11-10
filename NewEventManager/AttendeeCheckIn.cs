using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NewEventManager
{
    public class AttendeeCheckIn
    {
        private int _id;
        private string _ecode;
        private string _ucode;
        private string _datetime;
        private string _flag;

        public AttendeeCheckIn()
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
        public string Ucode
        {
            get { return _ucode; }
            set { _ucode = value; }
        }
        public string Ecode
        {
            get { return _ecode; }
            set { _ecode = value; }
        }

        public string checkinDatetime
        {
            get { return _datetime; }
            set { _datetime = value; }
        }
        public string Flag
        {
            get { return _flag; }
            set { _flag = value; }
        }
    }
}