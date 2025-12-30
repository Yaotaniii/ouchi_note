class ContractsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resident
  before_action :set_contract, only: [:show, :edit, :update, :destroy]
  before_action :authorize_owner!, only: [:new, :create, :edit, :update, :destroy]

  def show
  end

  def new
    @contract = @resident.build_contract
  end

  def create
    @contract = @resident.build_contract(contract_params)
    if @contract.save
      log_activity('create', '契約', "#{@resident.name}さんの契約")
      redirect_to resident_contract_path(@resident), notice: "契約情報を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @contract.update(contract_params)
      log_activity('update', '契約', "#{@resident.name}さんの契約")
      redirect_to resident_contract_path(@resident), notice: "契約情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @contract.destroy
    log_activity('destroy', '契約', "#{@resident.name}さんの契約")
    redirect_to resident_path(@resident), notice: "契約情報を削除しました"
  end

  private

  def set_resident
    @resident = Resident.find(params[:resident_id])
  end

  def set_contract
    @contract = @resident.contract
  end

  def contract_params
    params.require(:contract).permit(
      :start_date, :end_date, :guarantor_name, :guarantor_phone,
      :guarantor_address, :deposit, :key_money, :deposit_returned, :notes
    )
  end

  def authorize_owner!
    unless current_user.owner?
      redirect_to resident_path(@resident), alert: "この操作はオーナーのみ可能です"
    end
  end
end