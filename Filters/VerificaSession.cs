using Crud2.Controllers;
using Crud2.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Crud2.Filters
{
    public class VerificaSession : ActionFilterAttribute
    {
        private AdmUsuario oUsuario;
        public override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            try
            {
                base.OnActionExecuted(filterContext);
                oUsuario = (AdmUsuario)HttpContext.Current.Session["User"];
                if (oUsuario == null)
                {
                    if (filterContext.Controller is AccesoController == false)
                    {
                        filterContext.HttpContext.Response.Redirect("/Acceso/Login");
                    }
                }
            }
            catch (Exception)
            {

                filterContext.Result = new RedirectResult("~/Acceso/Login");
            }
        }
    }
}