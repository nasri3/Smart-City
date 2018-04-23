/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.beans;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Wissem
 */
@Entity
@Table(name = "notification")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Notification.findAll", query = "SELECT n FROM Notification n")
    , @NamedQuery(name = "Notification.findByIdNotification", query = "SELECT n FROM Notification n WHERE n.idNotification = :idNotification")
    , @NamedQuery(name = "Notification.findByDatedecreation", query = "SELECT n FROM Notification n WHERE n.datedecreation = :datedecreation")
    , @NamedQuery(name = "Notification.findByTexte", query = "SELECT n FROM Notification n WHERE n.texte = :texte")
    , @NamedQuery(name = "Notification.findByVu", query = "SELECT n FROM Notification n WHERE n.vu = :vu")})
public class Notification implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "IdNotification")
    private Integer idNotification;
    @Basic(optional = false)
    @NotNull
    @Column(name = "Date de création")
    @Temporal(TemporalType.TIMESTAMP)
    private Date datedecreation = new Date();
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 5000)
    @Column(name = "Texte")
    private String texte;
    @Basic(optional = false)
    @NotNull
    @Column(name = "Vu")
    private boolean vu = false;
    @JoinColumn(name = "Destinataire", referencedColumnName = "IdCompte")
    @ManyToOne(optional = false)
    private Compte destinataire;
    @JoinColumn(name = "Expéditeur", referencedColumnName = "IdCompte")
    @ManyToOne
    private Compte expediteur;
    @JoinColumn(name = "Publication", referencedColumnName = "IdPublication")
    @ManyToOne
    private Publication publication = null;

    public Notification() {
    }

    public Notification(Integer idNotification) {
        this.idNotification = idNotification;
    }

    public Notification(Integer idNotification, Date datedecreation, String texte, boolean vu) {
        this.idNotification = idNotification;
        this.datedecreation = datedecreation;
        this.texte = texte;
        this.vu = vu;
    }

    public Integer getIdNotification() {
        return idNotification;
    }

    public void setIdNotification(Integer idNotification) {
        this.idNotification = idNotification;
    }

    public Date getDatedecreation() {
        return datedecreation;
    }

    public void setDatedecreation(Date datedecreation) {
        this.datedecreation = datedecreation;
    }

    public String getTexte() {
        return texte;
    }

    public void setTexte(String texte) {
        this.texte = texte;
    }

    public boolean getVu() {
        return vu;
    }

    public void setVu(boolean vu) {
        this.vu = vu;
    }

    public Compte getDestinataire() {
        return destinataire;
    }

    public void setDestinataire(Compte destinataire) {
        this.destinataire = destinataire;
    }

    public Compte getExpediteur() {
        return expediteur;
    }

    public void setExpediteur(Compte expediteur) {
        this.expediteur = expediteur;
    }

    public Publication getPublication() {
        return publication;
    }

    public void setPublication(Publication publication) {
        this.publication = publication;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idNotification != null ? idNotification.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Notification)) {
            return false;
        }
        Notification other = (Notification) object;
        if ((this.idNotification == null && other.idNotification != null) || (this.idNotification != null && !this.idNotification.equals(other.idNotification))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.beans.Notification[ idNotification=" + idNotification + " ]";
    }
    
}
