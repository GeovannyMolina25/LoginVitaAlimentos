using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Crud2.Models;

namespace Crud2.Controllers
{
    public class AdmUsuariosController : Controller
    {
        private readonly SistemaEntities db = new SistemaEntities();
        private void CargarDatosUsuario()
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
            ViewBag.codRol = oRoles;
            ViewBag.codSitio = new SelectList(db.AdmSitio, "codSitio", "nombreSitio");
            var permisos = db.AdmPermisos.Where(p => oRoles.Contains(p.codRol)).ToList(); // Obtener todos los registros que corresponden a los roles del usuario
            ViewBag.Permisos = permisos; // Pasar la lista de permisos a la 
        }
        // GET: AdmUsuarios
        public ActionResult Index()
        {
            CargarDatosUsuario();
            
            var admUsuario = db.AdmUsuario.Include(a => a.AdmSitio).Include(a => a.AdmSitio.AdmEmpresa);
            
            return View(admUsuario.ToList());
        }

        // GET: AdmUsuarios/Details/5
        public ActionResult ResetPassword(string usu)
        {
            CargarDatosUsuario();
            if (ModelState.IsValid)
            {
                AdmUsuario admUsuario = db.AdmUsuario.Find(usu);
                admUsuario.resetPass = null;
                admUsuario.contraseña = "Vita.2023";
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            
            return View(usu);
        }
        public ActionResult Details(string id)
        {
            CargarDatosUsuario();
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AdmUsuario admUsuario = db.AdmUsuario.Find(id);
            ViewBag.usu = id;
            if (admUsuario == null)
            {
                return HttpNotFound();
            }
            return View(admUsuario);
        }


        // GET: AdmUsuarios/Create
        public ActionResult Create()
        {
            CargarDatosUsuario();
            ViewBag.codEmpresa = new SelectList(db.AdmEmpresa, "codEmpresa", "nombreEmpresa");
            ViewBag.codSitio = new SelectList(db.AdmSitio, "codSitio", "nombreSitio");
            return View();
        }
        public ActionResult GetSitiosByEmpresa(string codEmpresa)
        {
            CargarDatosUsuario();
            var sitios = db.AdmSitio.Where(s => s.codEmpresa == codEmpresa).ToList();
            var sitiosSelectList = new SelectList(sitios, "codSitio", "nombreSitio");
            return Json(sitiosSelectList, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "codRegistro,codUsuario,contraseña,correo,token,codSitio,activo,codEmpresa")] AdmUsuario admUsuario)
        {
            CargarDatosUsuario();
            if (ModelState.IsValid)
            {
                db.AdmUsuario.Add(admUsuario);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.codEmpresa = new SelectList(db.AdmEmpresa, "codEmpresa", "nombreEmpresa", admUsuario.codEmpresa);
            return View(admUsuario);
        }

        // GET: AdmUsuarios/Edit/5
        public ActionResult Edit(string id)
        {
            CargarDatosUsuario();
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AdmUsuario admUsuario = db.AdmUsuario.Find(id);
            if (admUsuario == null)
            {
                return HttpNotFound();
            }
            ViewBag.codEmpresa = new SelectList(db.AdmEmpresa, "codEmpresa", "nombreEmpresa", admUsuario.codEmpresa);
            return View(admUsuario);
        }

        // POST: AdmUsuarios/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "codRegistro,codUsuario,contraseña,correo,token,codSitio,activo,codEmpresa")] AdmUsuario admUsuario)
        {
            CargarDatosUsuario();
            if (ModelState.IsValid)
            {
                db.Entry(admUsuario).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.codEmpresa = new SelectList(db.AdmEmpresa, "codEmpresa", "nombreEmpresa", admUsuario.codEmpresa);
            return View(admUsuario);
        }

        // GET: AdmUsuarios/Delete/5
        public ActionResult Delete(string id)
        {
            CargarDatosUsuario();
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AdmUsuario admUsuario = db.AdmUsuario.Find(id);
            ViewBag.id = admUsuario.codUsuario;
            if (admUsuario == null)
            {
                return HttpNotFound();
            }
            return View(admUsuario);
        }

        public ActionResult DeleteConfirmed(string id)
        {
            using (var context = new SistemaEntities())
            {
                AdmUsuario admUsuario = db.AdmUsuario.Find(id);
                db.AdmUsuario.Remove(admUsuario);
                db.SaveChanges();
            }
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
