/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.beans;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Wissem
 */
@Entity
@Table(name = "compte")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Compte.findAll", query = "SELECT c FROM Compte c order by c.idCompte desc"),
    @NamedQuery(name = "Compte.findByType", query = "SELECT c FROM Compte c where c.type = :type")})
public class Compte implements Serializable {

    private static final long serialVersionUID = 1L;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 25)
    @Column(name = "Nom")
    private String nom;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 25)
    @Column(name = "Prenom")
    private String prenom;
    @Basic(optional = false)
    @NotNull
    @Column(name = "DateDeNaissance")
    @Temporal(TemporalType.DATE)
    private Date dateDeNaissance;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 8)
    @Column(name = "IdCompte")
    private String idCompte;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "Ville")
    private String ville;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "PhotoDeProfil")
    private String photoDeProfil = "avatar.png";
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "MotDePasse")
    private String motDePasse;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 25)
    @Column(name = "Type")
    private String type = "Utilisateur";
    @Basic(optional = false)
    @NotNull
    @Size(min = 0, max = 50)
    @Column(name = "Gouvernorat-interet")
    private String gouvernorat_interet = "Tous";
    @Basic(optional = false)
    @NotNull
    @Size(min = 0, max = 50)
    @Column(name = "Catégorie-interet")
    private String categorie_interet = "Tous";
    
    @JoinColumn(name = "Etablissement", referencedColumnName = "idEtablissement")
    @ManyToOne
    private Etablissement etablissement;

    @JoinTable(name = "signalisation", joinColumns = {
        @JoinColumn(name = "compte", referencedColumnName = "IdCompte")}, inverseJoinColumns = {
        @JoinColumn(name = "publication", referencedColumnName = "IdPublication")})
    @ManyToMany(fetch = FetchType.EAGER)
    private List<Publication> publicationsSignales;
    
    @JoinTable(name = "suivi", joinColumns = {
        @JoinColumn(name = "Compte", referencedColumnName = "IdCompte")}, inverseJoinColumns = {
        @JoinColumn(name = "Publication", referencedColumnName = "IdPublication")})
    @ManyToMany(fetch = FetchType.EAGER)
    private List<Publication> publicationsSuivis;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "compte")
    private List<Publication> publicationList;
    
    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, mappedBy = "destinataire")
    @OrderBy("idNotification desc")
    private List<Notification> notificationList;
    @OneToMany(mappedBy = "expediteur")
    private List<Notification> notificationList1;
    
    public Compte() {
    }

    public Compte(String idCompte) {
        this.idCompte = idCompte;
    }

    public Compte(String idCompte, String nom, String prenom, Date dateDeNaissance, String ville, String photoDeProfil, String motDePasse, String type, String villeinteret, String categorieinteret) {
        this.idCompte = idCompte;
        this.nom = nom;
        this.prenom = prenom;
        this.dateDeNaissance = dateDeNaissance;
        this.ville = ville;
        this.photoDeProfil = photoDeProfil;
        this.motDePasse = motDePasse;
        this.type = type;
        this.gouvernorat_interet = villeinteret;
        this.categorie_interet = categorieinteret;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getDateDeNaissance() {
        String dn = new SimpleDateFormat("yyyy-MM-dd").format(dateDeNaissance);
        return dn;
    }

    public void setDateDeNaissance(Date dateDeNaissance) {
        this.dateDeNaissance = dateDeNaissance;
    }

    public String getIdCompte() {
        return idCompte;
    }

    public void setIdCompte(String idCompte) {
        this.idCompte = idCompte;
    }

    public String getVille() {
        return ville;
    }

    public void setVille(String ville) {
        this.ville = ville;
    }

    public String getPhotoDeProfil() {
        return photoDeProfil;
    }

    public void setPhotoDeProfil(String photoDeProfil) {
        this.photoDeProfil = photoDeProfil;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getGouvernorat_interet() {
        return gouvernorat_interet;
    }

    public void setGouvernorat_interet(String gouvernorat_interet) {
        this.gouvernorat_interet = gouvernorat_interet;
    }

    public String getCategorie_interet() {
        return categorie_interet;
    }

    public void setCategorie_interet(String categorie_interet) {
        this.categorie_interet = categorie_interet;
    }

    @XmlTransient
    public List<Publication> getPublicationsSignales() {
        return publicationsSignales;
    }

    public void setPublicationsSignales(List<Publication> publicationsSignales) {
        this.publicationsSignales = publicationsSignales;
    }

    public void SignalerPublication(Publication publication) {
        this.publicationsSignales.add(publication);
    }

    public boolean DejaSignaler(Publication publication) {
        return publicationsSignales.contains(publication);
    }

    @XmlTransient
    public List<Notification> getNotificationList() {
        return notificationList;
    }
    
    public int getNbreNotificationsNonVus(){
        int nbNotif = 0;
        for (Notification n : notificationList) {
            if(!n.getVu()) nbNotif++;
        }
        return nbNotif;
    }
    
    public void setNotificationsVus(){
        for (Notification n : notificationList) {
            n.setVu(true);
        }
    }
    
    public void setNotificationList(List<Notification> notificationList) {
        this.notificationList = notificationList;
    }

    @XmlTransient
    public List<Notification> getNotificationList1() {
        return notificationList1;
    }

    public void setNotificationList1(List<Notification> notificationList1) {
        this.notificationList1 = notificationList1;
    }

    @XmlTransient
    public List<Publication> getPublicationList() {
        return publicationList;
    }

    public void setPublicationList(List<Publication> publicationList) {
        this.publicationList = publicationList;
    }

    @XmlTransient
    public List<Publication> getPublicationsSuivis() {
        return publicationsSuivis;
    }

    public void setPublicationsSuivis(List<Publication> publicationsSuivis) {
        this.publicationsSuivis = publicationsSuivis;
    }

    public void SuivrePublication(Publication publication) {
        this.publicationsSuivis.add(publication);
    }

    public boolean DejaSuivi(Publication publication) {
        return publicationsSuivis.contains(publication);
    }

    public Etablissement getEtablissement() {
        return etablissement;
    }

    public void setEtablissement(Etablissement etablissement) {
        this.etablissement = etablissement;
    }
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idCompte != null ? idCompte.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Compte)) {
            return false;
        }
        Compte other = (Compte) object;
        if ((this.idCompte == null && other.idCompte != null) || (this.idCompte != null && !this.idCompte.equals(other.idCompte))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.beans.Compte[ idCompte=" + idCompte + " ]";
    }
}
