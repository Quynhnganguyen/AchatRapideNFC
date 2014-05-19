class Api::ClientsController < ApplicationController
  def sign_in
    @client = Client.where(email: params[:email]).first
    if @client.blank?
      render json: { status: 'Invalid client', message: "Invalid client"}
    elsif @client.valid_password?(params[:password])
      render json: { status: "success", message: "Login success", clientname: @client.name, 
                     client_id: @client.id, password_token: @client.authentication_token}
    else
      @client = nil
      render json: { status: 'Invalid password', message: "Invalid password"}
    end
  end

  def sign_out
    current_client.reset_password_token!
    render text: 'Logout success'
  end

  # def sign_up

  # end

  #api/clients/liste_magasins
  def liste_magasins # liste magasins
    @magasins = Magasin.all
    results = @magasins.map {|m| {
                  :magasin_id => m.id,
                  :magasin_nom => m.nom_magasin, 
                  :magasin_adresse => m.adresse_magasin}}
    render json: results
  end

  def produits_magasin #consulte les produit par magasin
    @produits = Produit.where(magasin_id: params[:magasin_id])
    results = @produits.map {|p| {
                  :produit_id => p.id,
                  :produit_nom => p.nom_produit
                  }}
    render json: results
  end

  def produits_type #consulte les produit par type
    @produits = Produit.where(type_de_produit_id: params[:type_de_produit_id])
    results = @produits.map {|p| {
                  :produit_id => p.id,
                  :produit_nom => p.nom_produit
                  }}
    render json: results
  end

  def produits_source #consulte les produit par source
    @produits = Produit.where(source_id: params[:source_id])
    results = @produits.map {|p| {
                  :produit_id => p.id,
                  :produit_nom => p.nom_produit
                  }}
    render json: results
  end

  def liste_sources
    @sources = Source.where(magasin_id: params[:magasin_id])
    results = @sources.map {|p| {
                  :source_id => p.id,
                  :source => p.pays, 
                  :magasin => p.magasin.nom_magasin}}
    render json: results
  end

  def liste_types
    @types = TypeDeProduit.where(magasin_id: params[:magasin_id])
    results = @types.map {|p| {
                  :type_id => p.id,
                  :type => p.type_produit, 
                  :magasin => p.magasin.nom_magasin}}
    render json: results
  end

  #api/clients/scan_nfc
  def scan_nfc
    @produit = Produit.where(nfc_id: params[:nfc_id])
    results = @produit.map {|p| {
                  :produit_id => p.id,
                  :produit_nom => p.nom_produit, 
                  :prix => p.prix,
                  :nombre => p.nombre,
                  :source => p.source.pays,
                  :type => p.type_de_produit.type_produit,
                  :nfc => p.nfc_id,
                  :magasin => p.magasin.nom_magasin}}
    render json: results
  end

  def show_produit #information d'un produit
    @produit = Produit.where(id: params[:id])
    results = @produit.map {|p| {
                  :produit_id => p.id,
                  :produit_nom => p.nom_produit, 
                  :prix => p.prix,
                  :nombre => p.nombre,
                  :source => p.source.pays,
                  :type => p.type_de_produit.type_produit,
                  :nfc => p.nfc_id,
                  :magasin => p.magasin.nom_magasin}}
    render json: results
  end

#liste acheter
  def add_liste_acheter
    @client = client
    @produit = produit
    if @client and @produit
      @achat2 = @client.liste_acheter.create(client_id: @client.id, produit_id: @produit.id)
      # @achat = @produit.liste_acheter.create(liste_acheter_params)
      @achat2.save
      if @achat2.save
         render json: { status: 'Valide', message: "Valide"}
      else 
        render json: { status: 'Invalide', message: "Invalide"}
      end
    else
      render json: { status: 'info invalide', message: "info invalide"}
    end
  end

  def show_liste_acheter
    @client = client
    @listes = ListeAcheter.where(client_id: @client.id)
    results = @listes.map {|p| {
                  :produit_id => p.produit.id,
                  :produit_nom => p.produit.nom_produit,
                  :prix => p.produit.prix,
                  :source => p.produit.source.pays,
                  :type => p.produit.type_de_produit.type_produit,
                  :nfc => p.produit.nfc_id,
                  :magasin => p.produit.magasin.nom_magasin
                  }}
    render json: results
  end # end liste acheter

#liste favorise
  def add_liste_favorise
    @client = client
    @produit = produit
    if @client and @produit
      @achat2 = @client.liste_favorise.create(client_id: @client.id, produit_id: @produit.id)
      # @achat = @produit.liste_acheter.create(liste_acheter_params)
      @achat2.save
      if @achat2.save
         render json: { status: 'Valide', message: "Valide"}
      else 
        render json: { status: 'Invalide', message: "Invalide"}
      end
    else
      render json: { status: 'info invalide', message: "info invalide"}
    end
  end

  def show_liste_favorise
    @client = client
    @listes = ListeFavorise.where(client_id: @client.id)
    results = @listes.map {|p| {
                  :produit_id => p.produit.id,
                  :prix => p.produit.prix,
                  :produit_nom => p.produit.nom_produit,
                  :source => p.produit.source.pays,
                  :type => p.produit.type_de_produit.type_produit,
                  :nfc => p.produit.nfc_id,
                  :magasin => p.produit.magasin.nom_magasin
                  }}
    render json: results
  end #end liste favorise

#liste noire
  def add_liste_noire
    @client = client
    @produit = produit
    if @client and @produit
      @achat2 = @client.liste_noire.create(client_id: @client.id, produit_id: @produit.id)
      # @achat = @produit.liste_acheter.create(liste_acheter_params)
      @achat2.save
      if @achat2.save
         render json: { status: 'Valide', message: "Valide"}
      else 
        render json: { status: 'Invalide', message: "Invalide"}
      end
    else
      render json: { status: 'info invalide', message: "info invalide"}
    end
  end

  def show_liste_noire
    @client = client
    @listes = ListeNoire.where(client_id: @client.id)
    results = @listes.map {|p| {
                  :produit_id => p.produit.id,
                  :prix => p.produit.prix,
                  :produit_nom => p.produit.nom_produit,
                  :source => p.produit.source.pays,
                  :type => p.produit.type_de_produit.type_produit,
                  :nfc => p.produit.nfc_id,
                  :magasin => p.produit.magasin.nom_magasin
                  }}
    render json: results
  end #end liste noire

  
  private

  def liste_acheter_params
    params.require(:liste_acheter).permit(:client_id, :produit_id) if params[:liste_acheter]
  end

  def client
    if params[:client_id]
      id = params[:client_id]
      Client.find(params[:client_id])
    end
  end

  def produit
    if params[:produit_id]
      id = params[:produit_id]
      Produit.find(params[:produit_id])
    end
  end

end
