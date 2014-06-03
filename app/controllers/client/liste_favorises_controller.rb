class Client::ListeFavorisesController < ApplicationController
  def index
		@client = client
		@listes= ListeFavorise.where(client_id: @client.id)
 	end

  def new
    @client = client
    @favorie = @client.liste_favorise.new
    @favorie.save
  end
 
  def create
    @client = client
    @produit = produit
    @produit_exite = ListeFavorise.exists?(produit_id: @produit.id)
    
    if @produit_exite
      @message= "Produit existed"
    else
      @favorie = @client.liste_favorise.create(client_id: @client.id, produit_id: @produit.id)
   	@favorie.save
      if @favorie.save
         flash[:notice] =  "produit has been successfully added in liste favoris."
     	else 
     		flash[:notice] =  "erroooooo"
    end
  end
  end

 def destroy
    @client = client
    @produit = @client.liste_favorise.find(params[:id])
    @produit.destroy

    respond_to do |format|
      format.html { redirect_to client_liste_favorises_index_path }
      format.json { head :no_content }
    end
  end


private
  def liste_favorise_params
      params.require(:liste_favorise).permit(:client_id, :produit_id) if params[:liste_favorise]
  
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
