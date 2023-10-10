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
    public class AdmUsuarioRolsController : Controller
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
        // GET: AdmUsuarioRols
        public ActionResult Index()
        {
            CargarDatosUsuario();
            var admUsuarioRol = db.AdmUsuarioRol.Include(a => a.AdmRol).Include(a => a.AdmUsuario);
            return View(admUsuarioRol.ToList());
        }

        // GET: AdmUsuarioRols/Details/5
        public ActionResult Details(int? id)
        {
            CargarDatosUsuario();
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AdmUsuarioRol admUsuarioRol = db.AdmUsuarioRol.Find(id);
            if (admUsuarioRol == null)
            {
                return HttpNotFound();
            }
            return View(admUsuarioRol);
        }

        // GET: AdmUsuarioRols/Create
        public ActionResult Create()
        {
            CargarDatosUsuario();
            ViewBag.codUsuario = new SelectList(db.AdmUsuario, "codUsuario", "codUsuario");
            ViewBag.db = db;
            return View();
        }

        // POST: AdmUsuarioRols/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "codUsuarioRol,codUsuario,codRol")] AdmUsuarioRol admUsuarioRol, string[] selectedRoles)
        {
            CargarDatosUsuario();
            if (ModelState.IsValid)
            {
                if (selectedRoles != null)
                {
                    var user = (AdmUsuario)Session["User"];
                    var roles = db.AdmRol.Where(r => selectedRoles.Contains(r.codRol));
                    List<AdmUsuarioRol> userRoles = new List<AdmUsuarioRol>();
                    foreach (var roleId in selectedRoles)
                    {
                        AdmUsuarioRol userRole = new AdmUsuarioRol();
                        userRole.codUsuario = admUsuarioRol.codUsuario;
                        userRole.codRol = roleId;
                        userRole.codEmpresa = user.codEmpresa;
                        userRoles.Add(userRole);
                    }
                    db.AdmUsuarioRol.AddRange(userRoles);
                }

                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.codUsuario = new SelectList(db.AdmUsuario, "codUsuario", "codUsuario", admUsuarioRol.codUsuario);
            return View(admUsuarioRol);
        }

        // GET: AdmUsuarioRols/Edit/5
        public ActionResult Edit(int? id)
        {
            CargarDatosUsuario();
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AdmUsuarioRol admUsuarioRol = db.AdmUsuarioRol.Find(id);
            if (admUsuarioRol == null)
            {
                return HttpNotFound();
            }
            ViewBag.codRol = new SelectList(db.AdmRol, "codRol", "nombreRol", admUsuarioRol.codRol);
            ViewBag.codUsuario = new SelectList(db.AdmUsuario, "codUsuario", "contraseña", admUsuarioRol.codUsuario);
            return View(admUsuarioRol);
        }

        // POST: AdmUsuarioRols/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "codUsuarioRol,codUsuario,codRol")] AdmUsuarioRol admUsuarioRol)
        {
            CargarDatosUsuario();
            if (ModelState.IsValid)
            {
                db.Entry(admUsuarioRol).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.codRol = new SelectList(db.AdmRol, "codRol", "nombreRol", admUsuarioRol.codRol);
            ViewBag.codUsuario = new SelectList(db.AdmUsuario, "codUsuario", "contraseña", admUsuarioRol.codUsuario);
            return View(admUsuarioRol);
        }

        // GET: AdmUsuarioRols/Delete/5
        public ActionResult Delete(int? id)
        {
            CargarDatosUsuario();
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            AdmUsuarioRol admUsuarioRol = db.AdmUsuarioRol.Find(id);
            ViewBag.id = id;
            if (admUsuarioRol == null)
            {
                return HttpNotFound();
            }
            return View(admUsuarioRol);
        }

        // POST: AdmUsuarioRols/Delete/5
        public ActionResult DeleteConfirmed(int id)
        {
            CargarDatosUsuario();
            AdmUsuarioRol admUsuarioRol = db.AdmUsuarioRol.Find(id);
            db.AdmUsuarioRol.Remove(admUsuarioRol);
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
