class Client::ListeNoiresController < ApplicationController
	def index
		@client = client
		@listes= ListeNoire.where(client_id: @client.id)
	end

  def new
    @client = client
    @achat = @client.liste_noire.new
    @achat.save
  end
 
  def create
    @client = client
    @produit = produit
    @produit_existe = ListeNoire.exists?(produit_id: @produit.id)

    if @produit_existe
      @message= "Produit est déjà dans liste noire"
    else
      @achat = @client.liste_noire.create(client_id: @client.id, produit_id: @produit.id)
   	  @achat.save
      if @achat.save
         flash[:notice] =  "produit has been successfully added in liste à noire."
      else 
     		flash[:notice] =  "erroooooo"
      end
    end
  end

  def destroy
    @client = client
    @produit = @client.liste_noire.find(params[:id])
    @produit.destroy

    respond_to do |format|
      format.html { redirect_to client_liste_noires_index_path }
      format.json { head :no_content }
    end
  end

private
  def liste_noire_params
    params.require(:liste_noire).permit(:client_id, :produit_id) if params[:liste_noire]
  end

  def client
  	if current_client.id
      id = current_client.id
      Client.find(current_client.id)
    end
  end

  def produit
  	if params[:produit_id]
      id = params[:produit_id]
      Produit.find(params[:produit_id])
  	end
  end
end
