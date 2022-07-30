FROM node:16.13.1-alpine3.14 as builder
WORKDIR /cart-api
COPY . ./
RUN npm i
RUN npm run build

FROM node:16.13.1-alpine3.14
COPY --from=builder /cart-api/dist ./
COPY --from=builder /cart-api/"package*.json" ./
RUN npm ci --production && npm cache clean --force

USER node
ENV PORT=4000
EXPOSE 4000

CMD ["node", "./main.js"]