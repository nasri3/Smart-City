package com.controller;

import com.DAO.CompteFacade;
import com.DAO.PublicationFacade;
import com.beans.Compte;
import com.beans.Publication;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

/**
 * Servlet implementation class UP_Servlet
 */
public class UP_Servlet extends HttpServlet {

    @EJB
    private CompteFacade compteFacade;

    @EJB
    private PublicationFacade publicationFacade;

    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public UP_Servlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws javax.servlet.ServletException
     * @throws java.io.IOException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List imageVideoAllowedTypes = Arrays.asList("image/jpeg", "image/gif", "image/png", "image/bmp", "image/svg+xml",
                "video/webm", "video/ogg", "video/mp4");
        Publication publication = new Publication();
        // Create a new file upload handler
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);

        // on recupère tous les champs du formulaire
        List itemlist;
        try {
            itemlist = upload.parseRequest(new ServletRequestContext(request));
            // Process the uploaded items
            Iterator iter = itemlist.iterator();

            while (iter.hasNext()) {
                FileItem itemFile = (FileItem) iter.next();
                // Process a regular form field
                if (!itemFile.isFormField()) {
                    long FileSize = itemFile.getSize();
                    if (FileSize != 0 && imageVideoAllowedTypes.contains(itemFile.getContentType())) {
                        System.out.println("Fichier valide");

                        publication.setType(itemFile.getContentType());
                        publication.setIdCompte((Compte) request.getSession().getAttribute("compte"));
                        publicationFacade.create(publication);

                        //upload the file
                        String extension = itemFile.getName().substring(itemFile.getName().lastIndexOf(".")).toLowerCase();
                        String uploadPath = getServletContext().getInitParameter("uploadPath");
                        String filename = publication.getIdPublication() + RandomStringUtils.randomAlphanumeric(15) + extension;

                        InputStream stream = itemFile.getInputStream();
                        FileOutputStream fout = new FileOutputStream(uploadPath + filename);
                        BufferedInputStream bin;
                        try (BufferedOutputStream bout = new BufferedOutputStream(fout)) {
                            bin = new BufferedInputStream(stream);
                            byte buf[] = new byte[4096];
                            while ((bin.read(buf)) != -1) {
                                bout.write(buf);
                            }
                        }
                        bin.close();

                        publication.setTitre(filename);

                    } else {
                        System.out.println("Fichier non valide");
                        response.setContentType("text/html;charset=UTF-8");
                        if (FileSize == 0) {
                            request.setAttribute("erreurUpload", "Fichier vide");
                        } else {
                            request.setAttribute("erreurUpload", "Le type du fichier " + itemFile.getContentType() + " est non valide");
                        }
                        request.getRequestDispatcher("/").include(request, response);
                        return;
                    }

                } else {
                    System.out.println("::::::::" + itemFile.getFieldName() + "::::" + itemFile.getString());
                    switch (itemFile.getFieldName()) {
                        case "Exprimer":
                            publication.setExprimer(itemFile.getString());
                            break;
                        case "Catégorie":
                            publication.setCategorie(itemFile.getString());
                            break;
                        case "Ville":
                            publication.setLieu(itemFile.getString());
                            break;
                        case "Anonyme":
                            publication.setAnonyme(true);
                            break;
                    }
                }
            }
        } catch (FileUploadException ex) {
            Logger.getLogger(UP_Servlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        publicationFacade.edit(publication);

        response.sendRedirect("/");
    }

}
