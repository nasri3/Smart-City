package com.controller;

import com.DAO.PublicationDAO;
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
    private PublicationDAO publicationDAO;

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

        request.setCharacterEncoding("UTF-8");
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
                    String FileType = itemFile.getContentType();
                    String extension = (FileType.equals("image/svg+xml")) ? "svg" : FileType.substring(FileType.lastIndexOf("/") + 1);
                    String uploadPath = getServletContext().getInitParameter("uploadPath");
                    String name = publication.getDatedecreation().replaceAll("[^0-9]", "") + RandomStringUtils.randomAlphanumeric(10) + "." + extension;
                    
                    //upload le fichier
                    String res = saveFile(itemFile, imageVideoAllowedTypes, 524288000, uploadPath + name);
                    if (res.equals("succes")) {
                        publication.setType(FileType);
                        publication.setCompte((Compte) request.getSession().getAttribute("compte"));
                        publication.setTitre(name);
                    } else {
                        response.setContentType("text/html;charset=UTF-8");
                        request.setAttribute("erreurUpload", res);
                        request.getRequestDispatcher("/").include(request, response);
                        return;
                    }
                } else {
                    String s = itemFile.getString("UTF-8");
                    System.out.println("::::::::" + itemFile.getFieldName() + "::::" + s);
                    switch (itemFile.getFieldName()) {
                        case "Description":
                            publication.setDescription(s);
                            break;
                        case "Catégorie":
                            publication.setCategorie(s);
                            break;
                        case "Ville":
                            publication.setVille(s);
                            break;
                        case "Anonyme":
                            publication.setAnonyme(true);
                            break;
                        case "Lat":
                            publication.setLat(Float.valueOf(s));
                            break;
                        case "Lng":
                            publication.setLng(Float.valueOf(s));
                            break;
                        case "Gouvernorat":
                            publication.setGouvernorat(s);
                            break;
                        case "Addresse":
                            publication.setAddresse(s);
                            break;
                    }
                }
            }
        } catch (FileUploadException ex) {
            Logger.getLogger(UP_Servlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        publicationDAO.create(publication);

        response.sendRedirect("/");
    }

    public static String saveFile(FileItem itemFile, List<String> AllowedTypes, long MaxFileSize, String filename) 
            throws IOException {

        long FileSize = itemFile.getSize();
        String FileType = itemFile.getContentType();
        if (FileSize != 0 && FileSize < MaxFileSize && AllowedTypes.contains(FileType)) {
            System.out.println("Fichier valide");

            InputStream stream = itemFile.getInputStream();
            FileOutputStream fout = new FileOutputStream(filename);
            BufferedInputStream bin;
            try (BufferedOutputStream bout = new BufferedOutputStream(fout)) {
                bin = new BufferedInputStream(stream);
                byte buf[] = new byte[4096];
                while ((bin.read(buf)) != -1) {
                    bout.write(buf);
                }
            }
            bin.close();
        } else {
            System.out.println("Fichier non valide");
            if(FileSize == 0){
                return "Fichier vide";
            }
            return "Le type du fichier " + FileType + " est non valide";
        }
        return "succes";
    }
}
