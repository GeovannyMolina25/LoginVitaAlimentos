  using Crud2.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace Crud2.Controllers
{
    public class HomeController : Controller 
    {

        private SistemaEntities db = new SistemaEntities();
        public ActionResult Index()
        {
            var user = (AdmUsuario)Session["User"];
            ViewBag.codUsuario = user.codUsuario;
            var empresa = (from d in db.AdmEmpresa
                           where d.codEmpresa == user.codEmpresa
                           select d.nombreEmpresa).FirstOrDefault();
            ViewBag.Empresa = empresa;
            
            var oRoles = (from d in db.AdmUsuarioRol
                          where d.codUsuario == user.codUsuario
                          select d.codRol).ToList();
            ViewBag.codRoles = oRoles;
            var permisos = db.AdmPermisos.Where(p => oRoles.Contains(p.codRol)).ToList(); // Obtener todos los registros que corresponden a los roles del usuario
            ViewBag.Permisos = permisos; // Pasar la lista de permisos a la vista

            
            return View();

        }

        public ActionResult Menu()
        {
            
            return View();
        }
        public ActionResult CerrarSesion()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Login", "Acceso");
        }
        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
        public JsonResult ObtenerPermisos()
        {
            // Aquí debes obtener tu lista de permisos desde donde la tengas en tu proyecto
            var permisos = ObtenerPermisosDeAlgunaManera();

            // Devuelve los datos en formato JSON
            return Json(permisos, JsonRequestBehavior.AllowGet);
        }

        // Método de ejemplo para obtener los permisos
        private List<AdmPermisos> ObtenerPermisosDeAlgunaManera()
        {
            var user = (AdmUsuario)Session["User"];
            ViewBag.codUsuario = user.codUsuario;
            var empresa = (from d in db.AdmEmpresa
                           where d.codEmpresa == user.codEmpresa
                           select d.nombreEmpresa).FirstOrDefault();
            ViewBag.Empresa = empresa;

            var oRoles = (from d in db.AdmUsuarioRol
                          where d.codUsuario == user.codUsuario
                          select d.codRol).ToList();
            ViewBag.codRoles = oRoles;
            var permisos = db.AdmPermisos.Where(p => oRoles.Contains(p.codRol)).ToList(); // Obtener todos los registros que corresponden a los roles del usuario
            ViewBag.Permisos = permisos; // Pasar la lista de permisos a la vista


            return permisos;
        }

    }
    
}