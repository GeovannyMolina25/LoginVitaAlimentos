using Crud2.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace Crud2.Controllers
{
    public class AccesoController : Controller
    {
        public ActionResult Login()
        {
            return View();
        }
        public ActionResult ErrorRol()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(string usu, string pass)
        {
            try
            {
                using (Models.SistemaEntities db = new Models.SistemaEntities())
                {
                    var oUser = (from d in db.AdmUsuario
                                 where d.codUsuario == usu.Trim()  && (d.activo.HasValue ? d.activo.Value : 0) == 1
                                 select d).FirstOrDefault();
                    if (oUser == null)
                    {
                        ViewBag.Error = "Usuario no encontrado o desactivado";
                        return View();
                    }
                    string contraseñaEncriptada = EncriptarSHA256(pass);
                    if ((oUser.contraseña == contraseñaEncriptada || oUser.contraseña == pass )&& oUser.resetPass != null)
                    {
                        Session["User"] = oUser;
                        return RedirectToAction("Index", "Home");
                    }
                    else if((oUser.contraseña == contraseñaEncriptada || oUser.contraseña == pass) && oUser.resetPass == null)
                    {
                        return RedirectToAction("NuevaContraseña", new {usu = usu});
                    }
                    else {
                        ViewBag.Error = "Usuario o Contraseña Invalida";
                        return View();
                    }
                }
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message + "ErrorAcceso";
                return View();
            }
        }
        public ActionResult NuevaContraseña(string usu)
        {
            ViewBag.usu = usu;
            return View();
        }

        [HttpPost]
        public ActionResult NuevaContraseña(string pass, string confpass, string usu)
        {
            try
            {
                if (pass == confpass)
                {
                    using (Models.SistemaEntities db = new Models.SistemaEntities())
                    {
                        var oUser = (from d in db.AdmUsuario
                                     where d.codUsuario == usu.Trim() && (d.activo.HasValue ? d.activo.Value : 0) == 1
                                     select d).FirstOrDefault();


                        if (oUser == null)
                        {
                            ViewBag.Error = "Usuario no encontrado o desactivado";
                            return View();
                        }

                        string contraseñaEncriptada = EncriptarSHA256(confpass);

                        oUser.resetPass = "Reseteada";
                        oUser.contraseña = contraseñaEncriptada;
                        db.SaveChanges();
                    }
                }
                else
                {
                    ViewBag.Error = "La contraseña y la confirmación de contraseña no coinciden";
                    return View();
                }

                return RedirectToAction("Login", "Acceso");
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message + "ErrorActualizarContraseña";
                return View();
            }
        }
        private string EncriptarSHA256(string cadena)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(cadena));
                StringBuilder builder = new StringBuilder();

                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }

                return builder.ToString();
            }
        }

    }
}