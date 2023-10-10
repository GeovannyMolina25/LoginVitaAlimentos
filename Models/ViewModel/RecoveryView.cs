using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Crud2.Models.ViewModel
{
    public class RecoveryView
    {
        [EmailAddress]
        [Required]
        public string Email { get; set; }
    }
}