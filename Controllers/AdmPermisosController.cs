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
    public class AdmPermisosController : Controller
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
            ViewBag.codRol = oRoles;
            var permisos = db.AdmPermisos.Where(p => oRoles.Contains(p.codRol)).ToList(); // Obtener todos los registros que corresponden a los roles del usuario
            ViewBag.Permisos = permisos; // Pasar la lista de permisos a la 
        }
        // GET: AdmPermisos
        public ActionResult Index()
        {
            CargarDatosUsuario();
            var admPermisos = db.AdmPermisos.Include(a => a.AdmRol);
            return View(admPermisos.ToList());
        }

        // GET: AdmPermisos/Details/5
        public ActionResult Details(int? id)
        {
            CargarDatosUsuario();
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AdmPermisos admPermisos = db.AdmPermisos.Find(id);
            if (admPermisos == null)
            {
                return HttpNotFound();
            }
            return View(admPermisos);
        }

        // GET: AdmPermisos/Create
        public ActionResult Create()
        {
            CargarDatosUsuario();
            ViewBag.codRol = new SelectList(db.AdmRol, "codRol", "nombreRol");
            List<PQPRODMAQUINA> equipos = db.PQPRODMAQUINA.ToList();
            ViewBag.Equipos = equipos;
            ViewBag.db = db;
            return View();
        }

        // POST: AdmPermisos/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "codRegistro,codForm,carpeta,codRol,vista,etiquetaMenu,codEmpresa,codEquipo")] AdmPermisos admPermisos)
        {
            CargarDatosUsuario();
            var user = (AdmUsuario)Session["User"];
            if (ModelState.IsValid)
            {
                admPermisos.codEmpresa = user.codEmpresa;
                db.AdmPermisos.Add(admPermisos);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.codRol = new SelectList(db.AdmRol, "codRol", "nombreRol", admPermisos.codRol);
            return View(admPermisos);
        }

        // GET: AdmPermisos/Edit/5
        public ActionResult Edit(int? id)
        {
            CargarDatosUsuario();
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AdmPermisos admPermisos = db.AdmPermisos.Find(id);
            if (admPermisos == null)
            {
                return HttpNotFound();
            }
            ViewBag.codRol = new SelectList(db.AdmRol, "codRol", "nombreRol", admPermisos.codRol);
            return View(admPermisos);
        }

        // POST: AdmPermisos/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "codRegistro,codForm,carpeta,codRol,vista,etiquetaMenu,codEmpresa")] AdmPermisos admPermisos)
        {
            CargarDatosUsuario();
            if (ModelState.IsValid)
            {
                db.Entry(admPermisos).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.codRol = new SelectList(db.AdmRol, "codRol", "nombreRol", admPermisos.codRol);
            return View(admPermisos);
        }

        public ActionResult DeleteConfirmed(int id)
        {
            CargarDatosUsuario();
            AdmPermisos admPermisos = db.AdmPermisos.Find(id);
            db.AdmPermisos.Remove(admPermisos);
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

        public string codEmp(string id)
        {
            using (SistemaEntities s = new SistemaEntities())
            {
                var emp = (from c in s.AdmUsuario
                           where c.codUsuario == id
                           select c.codEmpresa).FirstOrDefault();
                
                return emp;
            }
        }
    }
}
