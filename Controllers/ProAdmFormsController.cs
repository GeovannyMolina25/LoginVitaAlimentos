using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls;
using Crud2.Models;

namespace Crud2.Controllers
{
    public class ProAdmFormsController : Controller
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


        // GET: ProAdmForms1
        
        public ActionResult Index(DateTime? fecha)
        {
            CargarDatosUsuario();
            var proAdmForm = db.ProAdmForm
                .Include(p => p.AdmEstado)
                .Include(p => p.AdmFormulario)
                .Include(p => p.PQPRODMAQUINA)
                .OrderByDescending(p => p.codRegistro); // ordenar por fecha de creación descendente
            DateTime fechaSeleccionada = fecha ?? (DateTime?)Session["fechaSeleccionada"] ?? DateTime.Now;

            // Almacenar la fecha seleccionada en la ViewBag para que se pueda usar en la vista
            ViewBag.Fecha = fechaSeleccionada;

            // Filtrar los registros por la fecha seleccionada y la etiquetaMenu
            var data = proAdmForm
                .Where(d => d.fechaRegistro.HasValue && DbFunctions.TruncateTime(d.fechaRegistro.Value) == fechaSeleccionada.Date)
                .ToList();
           
            // Almacenar la fecha seleccionada en la sesión
            Session["fechaSeleccionada"] = fechaSeleccionada;

            return View(data);
        }

        public ActionResult Details(string codEstado, string codEquipo, DateTime? fecha, int codRegistro)
        {

            fecha = fecha ?? DateTime.MinValue;
            CargarDatosUsuario();
            if (fecha == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            ViewBag.Fecha = fecha;
            ViewBag.codEstado = codEstado;
            ViewBag.codEquipo = codEquipo;
            ViewBag.codRegistro = codRegistro;
            if(codEquipo == "REDA1" || codEquipo == "REDA2")
            {
                var proRegOprEstREDA1 = db.ProRegOprEstREDA1
               .Include(p => p.AdmUsuario)
               .Include(p => p.ProAdmForm)
               .Include(p => p.ProParametro)
               .Include(p => p.ProAdmForm.AdmEstado)
               .Where(p => p.ProAdmForm.codEquipo == codEquipo)
               .Where(p => p.fechaTrabajoProReg == fecha)
               .Where(p => p.codRegistroFormulario == codRegistro)
               .OrderBy(p => p.horaTrabajoProReg)
               .ThenBy(p => p.valorProReg);
                var valoresPorHora = proRegOprEstREDA1
                .GroupBy(p => p.ProParametro.nombreParametro)
                .ToDictionary(
                    g => g.Key,
                    g => g.GroupBy(p => p.horaTrabajoProReg)
                        .ToDictionary(
                            g2 => g2.Key,
                            g2 => g2.First().valorProReg
                        )
                );

                ViewBag.ValoresPorHora = valoresPorHora;
            }
            else if(codEquipo == "ASEPTICO1" || codEquipo == "ASEPTICO2")
            {
                var proRegOprTanASE = db.ProRegOprTanASE
                .Include(p => p.AdmUsuario)
                .Include(p => p.ProAdmForm)
                .Include(p => p.ProParametro)
                .Include(p => p.ProAdmForm.AdmEstado)
                .Where(p => p.ProAdmForm.codEquipo == codEquipo)
                .Where(p => p.fechaTrabajoProReg == fecha)
                .Where(p => p.codRegistroFormulario == codRegistro)
                .OrderBy(p => p.horaTrabajoProReg)
                .ThenBy(p => p.valorProReg);
                
                var valoresPorHora = proRegOprTanASE
                .GroupBy(p => p.ProParametro.nombreParametro)
                .ToDictionary(
                    g => g.Key,
                    g => g.GroupBy(p => p.horaTrabajoProReg)
                        .ToDictionary(
                            g2 => g2.Key,
                            g2 => g2.First().valorProReg
                        )
                );

                ViewBag.ValoresPorHora = valoresPorHora;
            }
            return View();
        }

        public ActionResult Aprobar(int id, string codEquipo)
        {
            var user = (AdmUsuario)Session["User"];
            CargarDatosUsuario();
            using (var context = new SistemaEntities())
            {
                TimeSpan horaAccion;
                DateTime nowA = DateTime.Now;
                horaAccion = new TimeSpan(nowA.Hour, nowA.Minute, nowA.Second);
                var proAcciones = new AdmProgAccionesFormulario();
                proAcciones = new AdmProgAccionesFormulario
                {
                    codRegistroFormulario = id,
                    creadoPor = user.codUsuario,
                    Accion = "Aprobado",
                    fechaAccion = DateTime.Now,
                    horaActual = horaAccion
                };
                db.AdmProgAccionesFormulario.Add(proAcciones);
                db.SaveChanges();

                var proAdmForm = context.ProAdmForm.FirstOrDefault(p => p.codRegistro == id);

                if (proAdmForm != null)
                {
                    proAdmForm.codEstado = "est2";
                    proAdmForm.aprobadoPor = user.codUsuario;
                    proAdmForm.fechaAprobacion = DateTime.Now;
                    TimeSpan horaActual;
                    DateTime now = DateTime.Now;
                    horaActual = new TimeSpan(now.Hour, now.Minute, now.Second);
                    proAdmForm.horaAprobacion = horaActual;
                    context.SaveChanges();
                }
            }

            return RedirectToAction("Index");
        }
        public ActionResult Rechazar(int id, string codEquipo)
        {
            var user = (AdmUsuario)Session["User"];
            CargarDatosUsuario();
            using (var context = new SistemaEntities())
            {
                TimeSpan horaAccion;
                DateTime nowA = DateTime.Now;
                horaAccion = new TimeSpan(nowA.Hour, nowA.Minute, nowA.Second);
                var proAcciones = new AdmProgAccionesFormulario();
                proAcciones = new AdmProgAccionesFormulario
                {
                    codRegistroFormulario = id,
                    creadoPor = user.codUsuario,
                    Accion = "Rechazado",
                    fechaAccion = DateTime.Now,
                    horaActual = horaAccion
                };
                db.AdmProgAccionesFormulario.Add(proAcciones);
                db.SaveChanges();
                var proAdmForm = context.ProAdmForm.FirstOrDefault(p => p.codRegistro == id);

                if (proAdmForm != null)
                {
                    proAdmForm.codEstado = "est4";
                    proAdmForm.fechaAprobacion = DateTime.Now;
                    TimeSpan horaActual;
                    DateTime now = DateTime.Now;
                    horaActual = new TimeSpan(now.Hour, now.Minute, now.Second);
                    proAdmForm.horaAprobacion = horaActual;
                    context.SaveChanges();
                }
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
