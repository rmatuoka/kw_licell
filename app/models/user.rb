class User < ActiveRecord::Base
  has_many :orders, :dependent => :destroy
  has_many :wishlists, :dependent => :destroy
  has_many :carts 
  
  acts_as_authentic
  acts_as_authorization_subject
  
  validates_uniqueness_of :email
  validates_presence_of :nome
  validates_presence_of :rg
  validates_presence_of :cpf, :message => "/ CNPJ não pode ficar em branco"
  validates_presence_of :phone
  validates_presence_of :address
  validates_presence_of :quarter
  validates_presence_of :cep
  validates_presence_of :sexo
  validates_presence_of :city  
  validate :validates_cpf 

    scoped_search :on => [:email, :nome, :cpf, :rg]
  
#  attr_accessible :nome, :sobrenome, :email, :crypted_password, :password_salt, :persistence_token, :sexo, :nascimento, :cpf, :rg
  attr_writer :role
    after_save :define_role
    
    def role
      @role
      if self.has_role? :admin
        @role = :admin
      elsif self.has_role? :supervisor
        @role = :supervisor
      elsif self.has_role? :user
        @role = :user
      end
    end
    
    def define_role
      if @role
        self.has_no_roles!
        self.has_role! @role
      end
    end
    
    def deliver_password_reset_instructions!
      reset_perishable_token!
    end
    
    def activate!
        self.active = true
        save
    end   
    
    def deliver_activation_instructions!
      reset_perishable_token!
      UserMailer.activation_instructions(self).deliver
    end

    def deliver_welcome!
      reset_perishable_token!
      UserMailer.welcome(self).deliver
    end
    
    protected
    #------------------------------------------------------------------------------
    # Rotinas para verificação de CPF e CNPJ
    # Linguagem: Ruby
    # Escrito por: André Camargo < andre@boaideia.inf.br > http://blog.boaideia.inf.br
    # Use, copie, melhore a vontade! Patches são bem-vindos...
    #------------------------------------------------------------------------------
    def check_cpf
      return false if cpf.nil?
      nulos = %w{12345678909 11111111111 22222222222 33333333333 44444444444 55555555555 66666666666 77777777777 88888888888 99999999999 00000000000}
      valor = cpf.scan /[0-9]/
      if valor.length == 11
        unless nulos.member?(valor.join)
          valor = valor.collect{|x| x.to_i}
          soma = 10*valor[0]+9*valor[1]+8*valor[2]+7*valor[3]+6*valor[4]+5*valor[5]+4*valor[6]+3*valor[7]+2*valor[8]
          soma = soma - (11 * (soma/11))
          resultado1 = (soma == 0 or soma == 1) ? 0 : 11 - soma
          if resultado1 == valor[9]
            soma = valor[0]*11+valor[1]*10+valor[2]*9+valor[3]*8+valor[4]*7+valor[5]*6+valor[6]*5+valor[7]*4+valor[8]*3+valor[9]*2
            soma = soma - (11 * (soma/11))
            resultado2 = (soma == 0 or soma == 1) ? 0 : 11 - soma
            return true if resultado2 == valor[10] # CPF válido
          end
        end
      end
      return false # CPF inválido
    end

    def check_cnpj
      return false if cpf.nil?

      nulos = %w{11111111111111 22222222222222 33333333333333 44444444444444 55555555555555 66666666666666 77777777777777 88888888888888 99999999999999 00000000000000}
      valor = cpf.scan /[0-9]/
      if valor.length == 14
        unless nulos.member?(valor.join)
          valor = valor.collect{|x| x.to_i}
          soma = valor[0]*5+valor[1]*4+valor[2]*3+valor[3]*2+valor[4]*9+valor[5]*8+valor[6]*7+valor[7]*6+valor[8]*5+valor[9]*4+valor[10]*3+valor[11]*2
          soma = soma - (11*(soma/11))
          resultado1 = (soma==0 || soma==1) ? 0 : 11 - soma
          if resultado1 == valor[12]
            soma = valor[0]*6+valor[1]*5+valor[2]*4+valor[3]*3+valor[4]*2+valor[5]*9+valor[6]*8+valor[7]*7+valor[8]*6+valor[9]*5+valor[10]*4+valor[11]*3+valor[12]*2
            soma = soma - (11*(soma/11))
            resultado2 = (soma == 0 || soma == 1) ? 0 : 11 - soma
            return true if resultado2 == valor[13] # CNPJ válido
          end
        end
      end
      return false # CNPJ inválido
    end
    
    def validates_cpf
      errors.add(:cpf, "/ CNPJ Inválido") if !check_cpf && !check_cnpj
    end
end