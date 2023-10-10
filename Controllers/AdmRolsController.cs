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
    public class AdmRolsController : Controller
    {
        private SistemaEntities db = new SistemaEntities();

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
            ViewBag.codRoles = oRoles;
            var permisos = db.AdmPermisos.Where(p => oRoles.Contains(p.codRol)).ToList(); // Obtener todos los registros que corresponden a los roles del usuario
            ViewBag.Permisos = permisos; // Pasar la lista de permisos a la vista
        }

        public ActionResult Index()
        {
            CargarDatosUsuario();
            return View(db.AdmRol.ToList());
        }

        // GET: AdmRols/Details/5
        public ActionResult Details(string id)
        {
            CargarDatosUsuario();
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AdmRol admRol = db.AdmRol.Find(id);
            if (admRol == null)
            {
                return HttpNotFound();
            }
            return View(admRol);
        }

        // GET: AdmRols/Create
        public ActionResult Create()
        {
            CargarDatosUsuario();

            return View();
        }

        // POST: AdmRols/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "codRegistro,codRol,nombreRol")] AdmRol admRol)
        {
            CargarDatosUsuario();
            var user = (AdmUsuario)Session["User"];
            if (ModelState.IsValid)
            {
                admRol.codEmpresa = user.codEmpresa;
                db.AdmRol.Add(admRol);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(admRol);
        }

        // GET: AdmRols/Edit/5
        public ActionResult Edit(string id)
        {
            CargarDatosUsuario();
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AdmRol admRol = db.AdmRol.Find(id);
            if (admRol == null)
            {
                return HttpNotFound();
            }
            return View(admRol);
        }

        // POST: AdmRols/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "codRegistro,codRol,nombreRol")] AdmRol admRol)
        {
            CargarDatosUsuario();
            if (ModelState.IsValid)
            {
                db.Entry(admRol).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(admRol);
        }

        // GET: AdmRols/Delete/5

        public ActionResult DeleteConfirmedRol(string id)
        {
            CargarDatosUsuario();
            AdmRol admRol = db.AdmRol.Find(id);
            db.AdmRol.Remove(admRol);
            db.SaveChanges();
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
