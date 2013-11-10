using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NewEventManager
{
    public class Exhibitors
    {
        private int id;
        private string company;
        private string eventCode;
        private int standno;
        private string catagory;
        private string address;
        private string phoneno;
        private string email;
        private string biography;
        private string website;
        private string contactname;
        private string position;
        private int sponsorshiplevel;
        private string _MIMEType;
        private string _MapMIMEType;
        private string _facebook;
        private string _twitter;
        private string _linkedIn;
        private string _Product1;
        private string _Product2;
        private string _Product3;
        private string _Product4;
        private string _Product5;
        private string _adminlink;

        public string AdminLink
        {
            get { return _adminlink; }
            set { _adminlink = value; }
        }
        public string MAPMIMEType
        {
            get { return _MapMIMEType; }
            set { _MapMIMEType = value; }
        }
        public string Facebook
        {
            get { return _facebook; }
            set { _facebook = value; }
        }
        public string Twitter
        {
            get { return _twitter; }
            set { _twitter = value; }
        }
        public string LinkedIn
        {
            get { return _linkedIn; }
            set { _linkedIn = value; }
        }
        private Byte[] _ImageData;
        public Exhibitors()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public int ID
        {
            get { return id; }
            set { id = value; }
        }

        public string EventCode
        {
            get { return eventCode; }
            set { eventCode = value; }
        }

        public string Company
        {
            get { return company; }
            set { company = value; }
        }

        public int StandNo
        {
            get { return standno; }
            set { standno = value; }
        }

        public string Category
        {
            get { return catagory; }
            set { catagory = value; }
        }
        public string Address
        {
            get { return address; }
            set { address = value; }
        }
        public string Phoneno
        {
            get { return phoneno; }
            set { phoneno = value; }
        }
        public string Biography
        {
            get { return biography; }
            set { biography = value; }
        }

        public string Website
        {
            get { return website; }
            set { website = value; }
        }
        public string Contactname
        {
            get { return contactname; }
            set { contactname = value; }
        }
        public string Position
        {
            get { return position; }
            set { position = value; }
        }
        public string Email
        {
            get { return email; }
            set { email = value; }
        }
        public int Sponsorshiplevel
        {
            get { return sponsorshiplevel; }
            set { sponsorshiplevel = value; }
        }
        public string MIMEType
        {
            get { return _MIMEType; }
            set { _MIMEType = value; }
        }
        public string Product1
        {
            get { return _Product1; }
            set { _Product1 = value; }
        }
        public string Product2
        {
            get { return _Product2; }
            set { _Product2 = value; }
        }
        public string Product3
        {
            get { return _Product3; }
            set { _Product3 = value; }
        }
        public string Product4
        {
            get { return _Product4; }
            set { _Product4 = value; }
        }
        public string Product5
        {
            get { return _Product5; }
            set { _Product5 = value; }
        }

    }
}