using Crud2.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Web;
using System.Web.Mvc;

namespace Crud2.Filters
{
    [AttributeUsage(AttributeTargets.Method, AllowMultiple = false)]
    public class Autorizacion : AuthorizeAttribute
    {
        private AdmUsuario oUsuario;
        private SistemaEntities db = new SistemaEntities();
        private String idRolO;

        public Autorizacion(String idRolO = "")
        {
            this.idRolO = idRolO;
        }

        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            try
            {
                oUsuario = (AdmUsuario)HttpContext.Current.Session["User"];
                var lista = from m in db.AdmUsuarioRol
                            where m.codUsuario == oUsuario.codUsuario
                            && m.codRol == idRolO
                            select m;

                if (lista.ToList().Count() == 0)
                {
                    filterContext.Result = new RedirectResult("~/Acceso/ErrorRol");
                }

            }
            catch (Exception)
            {
                filterContext.Result = new RedirectResult("~/Acceso/ErrorRol");
            }


        }

        public String getRolO(String idRolO)
        {
            var listaR = from ro in db.AdmUsuarioRol
                         where ro.codUsuario == oUsuario.codUsuario
                         && ro.codRol == idRolO
                         select ro.codRol;
            String rolO;
            try
            {
                rolO = listaR.First();
            }
            catch (Exception)
            {

                rolO = "";
            }
            return rolO;
        }
    }
}