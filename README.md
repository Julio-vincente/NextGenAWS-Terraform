# Terraform Modules

<p align="center">
  <img src="https://github.com/devicons/devicon/blob/master/icons/terraform/terraform-original.svg" width="130">
</p>

Este repositório contém módulos do Terraform para facilitar a automação e o gerenciamento de recursos na AWS. Cada módulo é projetado para ser reutilizável, configurável e fácil de implementar, com foco na segurança, escalabilidade e boas práticas.

## Índice

- [Visão Geral](#visão-geral)
- [Módulos Disponíveis](#módulos-disponíveis)
- [Pré-requisitos](#pré-requisitos)
- [Como Usar](#como-usar)

## Visão Geral

Este repositório é dedicado ao gerenciamento de infraestrutura utilizando o Terraform, com foco principalmente em serviços da AWS como ECS, RDS, VPC, ACM e Route 53. Os módulos são criados para automatizar tarefas repetitivas e garantir que a infraestrutura seja configurada de maneira eficiente, com base em boas práticas.

## Módulos Disponíveis

- **VPC**: Criação e configuração de uma VPC com sub-redes públicas e privadas, NAT Gateway e regras de segurança.
- **ECS**: Provisionamento de instâncias EC2, incluindo configuração de segurança e permissões de IAM.
- **RDS**: Criação de banco de dados relacional no Amazon RDS, com suporte para várias configurações.
- **Secrets Manager**: Configuração de buckets S3, com políticas de acesso e criptografia.
- **IAM**: Criação de políticas, roles e usuários do IAM para gestão de acesso.
- **CloudWatch**: Provisionamento de clusters e serviços no Amazon ECS, incluindo integração com o ECR.
- **WAF**: Criação de uma distribuição do CloudFront para otimização da entrega de conteúdo.
- **Route 53**: Gerenciamento de registros de DNS para configuração de domínios e subdomínios.
- **GuardDuty**: Provisionamento de uma distribuição do CloudFront para otimização da entrega de conteúdo.
- **Certificate Manager**: Criação de certificados para uso em recursos da AWS, como ALBs e CloudFront.

## Pré-requisitos

Antes de usar os módulos, é necessário ter o Terraform instalado e uma conta AWS configurada com as permissões adequadas para criar os recursos desejados.

- Terraform 0.12 ou superior
- Conta AWS configurada com `AWS_ACCESS_KEY_ID` e `AWS_SECRET_ACCESS_KEY`, ou com credenciais configuradas via AWS CLI

## Como Usar

1. Clone o repositório:

    ```bash
    git clone https://github.com/Julio-vincente/NextGenAWS-Terraform.git
    cd src-terraform
    ```

2. Inicialize o Terraform:

    ```bash
    terraform init
    ```

3. Valide o ambiente:

    ```bash
    terraform validate
    ```

4. Revise o plano de execução:

    ```bash
    terraform plan
    ```

5. Aplique a configuração para criar os recursos:

    ```bash
    terraform apply --auto-approve
    ```

6. Para deletar os recursos, execute:

    ```bash
    terraform destroy --auto-approve
    ```